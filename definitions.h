#ifndef DEFINITIONS_H
#define DEFINITIONS_H

typedef struct node {
    char *type;
    union {
        int num;
        char *id;
        struct { struct node *left; struct node *right; } op;
    } value;
} Node;

Node* create_node(char *type);
Node* create_num_node(int num);
Node* create_id_node(char *id);
Node* create_op_node(char *type, Node *left, Node *right);

void print_ast(Node *node);
void free_ast(Node *node);

#endif // DEFINITIONS_H

