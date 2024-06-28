%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "definitions.h"
#include "bison.tab.h"
#include "codegen.h"

// Declaração da variável yyin
extern FILE *yyin;

void yyerror(const char *s);
int yylex(void);

%}

%union {
    int num;
    char *id;
    char *str;
}

%token <num> NUMBER
%token <id> IDENTIFIER
%token <str> STRING
%token PRINT IF THEN ELSE ELSEIF END WHILE DO FOR TO NEXT INPUT LET ASSIGN STEP
%token EQ NE LE GE

%type <str> program statement_list statement assignment print if_statement while_statement for_statement input expression_statement expression term factor condition comparison_op elseif_statements body

%precedence IFX
%nonassoc ELSE

%%

program:
    statement_list { $$ = generate_program($1); printf("%s\n", $$); }
    ;

statement_list:
    statement { $$ = $1; }
    | statement statement_list { $$ = generate_statement_list($1, $2); }
    ;

statement:
    assignment { $$ = $1; }
    | print { $$ = $1; }
    | if_statement { $$ = $1; }
    | while_statement { $$ = $1; }
    | for_statement { $$ = $1; }
    | input { $$ = $1; }
    | expression_statement { $$ = $1; }
    ;

assignment:
    LET IDENTIFIER ASSIGN expression {
        $$ = generate_assignment($2, $4);
    }
    ;

print:
    PRINT expression {
        $$ = generate_print($2);
    }
    ;

body:
    statement_list { 
        $$ = increase_indent($1); 
    }
    ;

if_statement:
    IF condition THEN body END IF {
        $$ = generate_if($2, $4, NULL);
    }
    | IF condition THEN body ELSE body END IF {
        $$ = generate_if($2, $4, $6);
    }
    | IF condition THEN body elseif_statements {
        $$ = generate_if_elseif($2, $4, $5);
    }
    ;

elseif_statements:
    ELSEIF condition THEN body END IF {
        $$ = generate_elseif($2, $4, NULL);
    }
    | ELSEIF condition THEN body ELSE body END IF {
        $$ = generate_elseif($2, $4, $6);
    }
    | ELSEIF condition THEN body elseif_statements {
        $$ = generate_elseif($2, $4, $5);
    }
    ;

while_statement:
    WHILE condition DO body END WHILE {
        $$ = generate_while($2, $4);
    }
    ;

for_statement:
    FOR IDENTIFIER ASSIGN expression TO expression DO body NEXT IDENTIFIER {
        $$ = generate_for($2, $4, $6, $8, NULL);
    }
    | FOR IDENTIFIER ASSIGN expression TO expression STEP expression DO body NEXT IDENTIFIER {
        $$ = generate_for($2, $4, $6, $10, $8);
    }
    ;

input:
    INPUT IDENTIFIER {
        $$ = generate_input($2);
    }
    ;

expression_statement:
    expression { $$ = generate_expression_statement($1); }
    ;

expression:
    term { $$ = $1; }
    | term '+' expression {
        $$ = malloc(strlen($1) + strlen($3) + 4);
        sprintf($$, "%s + %s", $1, $3);
    }
    | term '-' expression {
        $$ = malloc(strlen($1) + strlen($3) + 4);
        sprintf($$, "%s - %s", $1, $3);
    }
    ;

term:
    factor { $$ = $1; }
    | factor '*' term {
        $$ = malloc(strlen($1) + strlen($3) + 4);
        sprintf($$, "%s * %s", $1, $3);
    }
    | factor '/' term {
        $$ = malloc(strlen($1) + strlen($3) + 4);
        sprintf($$, "%s / %s", $1, $3);
    }
    ;

factor:
    NUMBER {
        $$ = malloc(20);
        sprintf($$, "%d", $1);
    }
    | STRING {
        $$ = strdup($1);
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
        $$ = generate_condition($1, $2, $3);
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

