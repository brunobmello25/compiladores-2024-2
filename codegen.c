#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "codegen.h"

void generate_program() {
    // No additional code needed for the whole program, 
    // as we generate and print statements as they are parsed
}

void generate_statement_list() {
    // Each statement is printed individually, no additional code needed here
}

void generate_statement() {
    // Each specific statement type is handled in its own function
}

void generate_assignment(char *id, char *expr) {
    printf("%s = %s\n", id, expr);
}

void generate_print(char *expr) {
    printf("print(%s)\n", expr);
}

void generate_if(char *cond, char *stmt_list) {
    printf("if %s:\n%s\n", cond, stmt_list);
}

void generate_while(char *cond, char *stmt_list) {
    printf("while %s:\n%s\n", cond, stmt_list);
}

void generate_for(char *id, char *start, char *end, char *stmt_list) {
    printf("for %s in range(%s, %s):\n%s\n", id, start, end, stmt_list);
}

void generate_input(char *id) {
    printf("%s = input()\n", id);
}

void generate_expression(char *expr) {
    printf("%s", expr);
}

void generate_term(char *term) {
    printf("%s", term);
}

void generate_factor(char *factor) {
    printf("%s", factor);
}

void generate_condition(char *left, char *op, char *right) {
    printf("%s %s %s", left, op, right);
}

void generate_comparison_op(char *op) {
    printf("%s", op);
}

