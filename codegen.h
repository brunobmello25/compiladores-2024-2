#ifndef CODEGEN_H
#define CODEGEN_H

char *increase_indent(char *original);
char* generate_program(char* stmt_list);
char* generate_statement_list(char* stmt1, char* stmt2);
char* generate_assignment(char *id, char *expr);
char* generate_print(char *expr);
char* generate_if(char *cond, char *stmt_list, char *else_part);
char* generate_if_elseif(char *cond, char *stmt_list, char *elseif_stmt);
char* generate_elseif(char *cond, char *stmt_list, char *else_part);
char* generate_while(char *cond, char *stmt_list);
char* generate_for(char *id, char *start, char *end, char *stmt_list);
char* generate_input(char *id);
char* generate_expression_statement(char *expr);
char* generate_expression(char *expr);
char* generate_term(char *term);
char* generate_factor(char *factor);
char* generate_condition(char *left, char *op, char *right);
char* generate_comparison_op(char *op);

#endif // CODEGEN_H

