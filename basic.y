%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "basic.tab.h"

// Definições para a AST
typedef struct Node {
    char *type;
    union {
        int num;
        char *id;
        struct { struct Node *left; struct Node *right; } op;
    } value;
} Node;

Node* create_node(char *type);
Node* create_num_node(int num);
Node* create_id_node(char *id);
Node* create_op_node(char *type, Node *left, Node *right);

void print_ast(Node *node);
void free_ast(Node *node);

void yyerror(const char *s);
int yylex(void);

Node *ast_root;  // Raiz da AST
%}

%union {
    int num;
    char *id;
    Node *node;
}

%token <num> NUMBER
%token <id> IDENTIFIER
%token PRINT IF THEN ENDIF WHILE DO ENDWHILE FOR TO NEXT INPUT
%token EQ NE LE GE

%type <node> program statement_list statement assignment print if_statement while_statement for_statement input expression term factor condition comparison_op

%%

program:
    statement_list { ast_root = $1; }
    ;

statement_list:
    statement { $$ = $1; }
    | statement statement_list {
        $$ = create_op_node("statement_list", $1, $2);
    }
    ;

statement:
    assignment { $$ = $1; }
    | print { $$ = $1; }
    | if_statement { $$ = $1; }
    | while_statement { $$ = $1; }
    | for_statement { $$ = $1; }
    | input { $$ = $1; }
    ;

assignment:
    IDENTIFIER '=' expression {
        $$ = create_op_node("assignment", create_id_node($1), $3);
    }
    ;

print:
    PRINT expression {
        $$ = create_op_node("print", $2, NULL);
    }
    ;

if_statement:
    IF condition THEN statement_list ENDIF {
        $$ = create_op_node("if", $2, $4);
    }
    ;

while_statement:
    WHILE condition DO statement_list ENDWHILE {
        $$ = create_op_node("while", $2, $4);
    }
    ;

for_statement:
    FOR IDENTIFIER '=' expression TO expression DO statement_list NEXT IDENTIFIER {
        $$ = create_op_node("for", create_id_node($2), create_op_node("range", $4, $6));
        $$->value.op.right = create_op_node("body", $8, create_id_node($10));
    }
    ;

input:
    INPUT IDENTIFIER {
        $$ = create_op_node("input", create_id_node($2), NULL);
    }
    ;

expression:
    term { $$ = $1; }
    | term '+' expression {
        $$ = create_op_node("add", $1, $3);
    }
    | term '-' expression {
        $$ = create_op_node("sub", $1, $3);
    }
    ;

term:
    factor { $$ = $1; }
    | factor '*' term {
        $$ = create_op_node("mul", $1, $3);
    }
    | factor '/' term {
        $$ = create_op_node("div", $1, $3);
    }
    ;

factor:
    NUMBER { $$ = create_num_node($1); }
    | IDENTIFIER { $$ = create_id_node($1); }
    | '(' expression ')' { $$ = $2; }
    ;

condition:
    expression comparison_op expression {
        $$ = create_op_node("condition", $1, $3);
    }
    ;

comparison_op:
    EQ { $$ = create_node("eq"); }
    | NE { $$ = create_node("ne"); }
    | '<' { $$ = create_node("lt"); }
    | '>' { $$ = create_node("gt"); }
    | LE { $$ = create_node("le"); }
    | GE { $$ = create_node("ge"); }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

Node* create_node(char *type) {
    Node *node = malloc(sizeof(Node));
    node->type = strdup(type);
    return node;
}

Node* create_num_node(int num) {
    Node *node = create_node("num");
    node->value.num = num;
    return node;
}

Node* create_id_node(char *id) {
    Node *node = create_node("id");
    node->value.id = strdup(id);
    return node;
}

Node* create_op_node(char *type, Node *left, Node *right) {
    Node *node = create_node(type);
    node->value.op.left = left;
    node->value.op.right = right;
    return node;
}

void print_ast(Node *node) {
    if (!node) return;
    if (strcmp(node->type, "num") == 0) {
        printf("%d", node->value.num);
    } else if (strcmp(node->type, "id") == 0) {
        printf("%s", node->value.id);
    } else {
        printf("(%s ", node->type);
        print_ast(node->value.op.left);
        printf(" ");
        print_ast(node->value.op.right);
        printf(")");
    }
}

void free_ast(Node *node) {
    if (!node) return;
    free(node->type);
    if (strcmp(node->type, "num") == 0) {
        // Nothing else to free
    } else if (strcmp(node->type, "id") == 0) {
        free(node->value.id);
    } else {
        free_ast(node->value.op.left);
        free_ast(node->value.op.right);
    }
    free(node);
}

int main(int argc, char **argv) {
    if (argc > 1) {
        FILE *file = fopen(argv[1], "r");
        if (!file) {
            fprintf(stderr, "Could not open file: %s\n", argv[1]);
            return 1;
        }
        yyin = file;
    }
    yyparse();
    print_ast(ast_root);
    printf("\n");
    free_ast(ast_root);
    return 0;
}

