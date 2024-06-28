#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "codegen.h"

void DEBUGPRINT(char *prefix,char *msg) {
    printf("-------------------\n");
    printf("%s:\n%s\n", prefix, msg);
    printf("-------------------\n");
}

char* generate_program(char* stmt_list) {
    return strdup(stmt_list);
}

char* generate_statement_list(char* stmt1, char* stmt2) {
    size_t len = strlen(stmt1) + strlen(stmt2) + 2; // +2 for the newline and null terminator
    char* result = malloc(len + 1); // +1 to ensure null terminator
    snprintf(result, len + 1, "%s\n%s", stmt1, stmt2);
    return result;
}

char* generate_assignment(char *id, char *expr) {
    size_t len = strlen(id) + strlen(expr) + 4; // +4 for " = " and null terminator
    char* result = malloc(len + 1); // +1 to ensure null terminator
    snprintf(result, len + 1, "%s = %s", id, expr);
    return result;
}

char* generate_print(char *expr) {
    size_t len = strlen(expr) + 9; // +9 for "print()" and null terminator
    char* result = malloc(len + 1); // +1 to ensure null terminator
    snprintf(result, len + 1, "print(%s)", expr);
    return result;
}

char* generate_if_elseif(char *cond, char *stmt_list, char *elseif_stmt) {
    size_t len = strlen(cond) + strlen(stmt_list) + strlen(elseif_stmt) + 18; // +18 for "if :\nelse:\n" and null terminator
    char* result = malloc(len + 1); // +1 to ensure null terminator

    snprintf(result, len + 1, "if %s:\n%s\n%s", cond, stmt_list, elseif_stmt);

    DEBUGPRINT("generate_if_elseif result", result);
    return result;
}

char* generate_if(char *cond, char *stmt_list, char *else_part) {
    size_t len = strlen(cond) + strlen(stmt_list) + (else_part ? strlen(else_part) : 0) + 18; // +18 for "if :\nelse:\n" and null terminator
    char* result = malloc(len + 1); // +1 to ensure null terminator
    if (else_part) {
        snprintf(result, len + 1, "if %s:\n%s\nelse:\n%s", cond, stmt_list, else_part);
    } else {
        snprintf(result, len + 1, "if %s:\n%s", cond, stmt_list);
    }
    DEBUGPRINT("generate_if result", result);
    return result;
}

char* generate_elseif(char *cond, char *stmt_list, char *else_part) {
    size_t len = strlen(cond) + strlen(stmt_list) + (else_part ? strlen(else_part) : 0) + 18; // +18 for "elif :\nelse:\n" and null terminator
    char* result = malloc(len + 1); // +1 to ensure null terminator
    if (else_part) {
        snprintf(result, len + 1, "elif %s:\n%s\nelse:\n%s", cond, stmt_list, else_part);
    } else {
        snprintf(result, len + 1, "elif %s:\n%s", cond, stmt_list);
    }
    DEBUGPRINT("generate_elseif result", result);
    return result;
}

char* generate_while(char *cond, char *stmt_list) {
    size_t len = strlen(cond) + strlen(stmt_list) + 10; // +10 for "while :\n" and null terminator
    char* result = malloc(len + 1); // +1 to ensure null terminator
    snprintf(result, len + 1, "while %s:\n%s", cond, stmt_list);
    return result;
}

char* generate_for(char *id, char *start, char *end, char *stmt_list) {
    size_t len = strlen(id) + strlen(start) + strlen(end) + strlen(stmt_list) + 20; // +20 for "for in range(, ):\n" and null terminator
    char* result = malloc(len + 1); // +1 to ensure null terminator
    snprintf(result, len + 1, "for %s in range(%s, %s):\n%s", id, start, end, stmt_list);
    return result;
}

char* generate_input(char *id) {
    size_t len = strlen(id) + 11; // +11 for " = input()" and null terminator
    char* result = malloc(len + 1); // +1 to ensure null terminator
    snprintf(result, len + 1, "%s = input()", id);
    return result;
}

char* generate_expression_statement(char *expr) {
    return strdup(expr);
}

char* generate_expression(char *expr) {
    return strdup(expr);
}

char* generate_term(char *term) {
    return strdup(term);
}

char* generate_factor(char *factor) {
    return strdup(factor);
}

char* generate_condition(char *left, char *op, char *right) {
    size_t len = strlen(left) + strlen(op) + strlen(right) + 3; // +3 for spaces and null terminator
    char* result = malloc(len + 1); // +1 to ensure null terminator
    snprintf(result, len + 1, "%s %s %s", left, op, right);
    return result;
}

char* generate_comparison_op(char *op) {
    return strdup(op);
}

