#ifndef CODEGEN_H
#define CODEGEN_H

void generate_program();
void generate_statement_list();
void generate_statement();
void generate_assignment(char *id, char *expr);
void generate_print(char *expr);
void generate_if(char *cond, char *stmt_list, char *else_part);
void generate_while(char *cond, char *stmt_list);
void generate_for(char *id, char *start, char *end, char *stmt_list);
void generate_input(char *id);
void generate_expression_statement(char *expr); // Adicionado
void generate_expression(char *expr);
void generate_term(char *term);
void generate_factor(char *factor);
void generate_condition(char *left, char *op, char *right);
void generate_comparison_op(char *op);

#endif // CODEGEN_H

