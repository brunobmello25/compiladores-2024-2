%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "definitions.h"
#include "basic.tab.h"
#include "codegen.h"

// Declaração da variável yyin
extern FILE *yyin;

void yyerror(const char *s);
int yylex(void);

%}

%union {
    int num;
    char *id;
    char *str; // Adicionado para armazenar expressões e outros valores gerados
}

%token <num> NUMBER
%token <id> IDENTIFIER
%token PRINT IF THEN ENDIF WHILE DO ENDWHILE FOR TO NEXT INPUT LET
%token EQ NE LE GE

%type <str> program statement_list statement assignment print if_statement while_statement for_statement input expression term factor condition comparison_op

%%

program:
    statement_list { generate_program(); }
    ;

statement_list:
    statement { generate_statement_list(); }
    | statement statement_list { generate_statement_list(); }
    ;

statement:
    assignment { /* No $1, $2, $3 are defined here */ }
    | print { /* No $1, $2 are defined here */ }
    | if_statement { /* No $1, $2, $3, $4 are defined here */ }
    | while_statement { /* No $1, $2, $3, $4 are defined here */ }
    | for_statement { /* No $1, $2, $3, $4, $5, $6, $7, $8 are defined here */ }
    | input { /* No $1, $2 are defined here */ }
    ;

assignment:
    LET IDENTIFIER '=' expression {
        generate_assignment($2, $4);
    }
    ;

print:
    PRINT expression {
        generate_print($2);
    }
    ;

if_statement:
    IF condition THEN statement_list ENDIF {
        generate_if($2, $4);
    }
    ;

while_statement:
    WHILE condition DO statement_list ENDWHILE {
        generate_while($2, $4);
    }
    ;

for_statement:
    FOR IDENTIFIER '=' expression TO expression DO statement_list NEXT IDENTIFIER {
        generate_for($2, $4, $6, $8);
    }
    ;

input:
    INPUT IDENTIFIER {
        generate_input($2);
    }
    ;

expression:
    term { $$ = $1; }
    | term '+' expression {
        $$ = malloc(strlen($1) + strlen($3) + 4);
        sprintf($$, "%s + %s", $1, $3);
        generate_expression($$);
    }
    | term '-' expression {
        $$ = malloc(strlen($1) + strlen($3) + 4);
        sprintf($$, "%s - %s", $1, $3);
        generate_expression($$);
    }
    ;

term:
    factor { $$ = $1; }
    | factor '*' term {
        $$ = malloc(strlen($1) + strlen($3) + 4);
        sprintf($$, "%s * %s", $1, $3);
        generate_term($$);
    }
    | factor '/' term {
        $$ = malloc(strlen($1) + strlen($3) + 4);
        sprintf($$, "%s / %s", $1, $3);
        generate_term($$);
    }
    ;

factor:
    NUMBER {
        $$ = malloc(20);
        sprintf($$, "%d", $1);
    }
    | IDENTIFIER {
        $$ = strdup($1);
    }
    | '(' expression ')' {
        $$ = strdup($2);
    }
    ;

condition:
    expression comparison_op expression {
        $$ = malloc(strlen($1) + strlen($3) + 4);
        sprintf($$, "%s %s %s", $1, $2, $3);
        generate_condition($1, $2, $3);
    }
    ;

comparison_op:
    EQ { $$ = strdup("=="); }
    | NE { $$ = strdup("!="); }
    | '<' { $$ = strdup("<"); }
    | '>' { $$ = strdup(">"); }
    | LE { $$ = strdup("<="); }
    | GE { $$ = strdup(">="); }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    yyparse();
    return 0;
}

