# TODO:

- [ ] Condições devem poder ser expressões avulsas
- [ ] mudar size_t pra int pq a gente é burro demais pra saber que size_t existe


# Gramática BASIC

```
PROGRAM     ::= STATEMENT_LIST
STATEMENT_LIST ::= STATEMENT STATEMENT_LIST | STATEMENT
STATEMENT   ::= ASSIGNMENT | PRINT | IF | WHILE | FOR | INPUT
ASSIGNMENT  ::= IDENTIFIER "=" EXPRESSION
PRINT       ::= "PRINT" EXPRESSION
IF          ::= "IF" CONDITION "THEN" STATEMENT_LIST "END IF"
WHILE       ::= "WHILE" CONDITION "DO" STATEMENT_LIST "END WHILE"
FOR         ::= "FOR" IDENTIFIER "=" EXPRESSION "TO" EXPRESSION "DO" STATEMENT_LIST "NEXT" IDENTIFIER
INPUT       ::= "INPUT" IDENTIFIER
EXPRESSION  ::= TERM | TERM "+" EXPRESSION | TERM "-" EXPRESSION
TERM        ::= FACTOR | FACTOR "*" TERM | FACTOR "/" TERM
FACTOR      ::= NUMBER | IDENTIFIER | "(" EXPRESSION ")"
CONDITION   ::= EXPRESSION COMPARISON_OP EXPRESSION
COMPARISON_OP ::= "==" | "!=" | "<" | ">" | "<=" | ">="
NUMBER      ::= [0-9]+
IDENTIFIER  ::= [a-zA-Z][a-zA-Z0-9]*
```

