%{
#include "definitions.h"
#include "basic.tab.h"
%}

DIGIT       [0-9]
LETTER      [a-zA-Z]
IDENTIFIER  {LETTER}({LETTER}|{DIGIT})*
NUMBER      {DIGIT}+
STRING      \"([^\\\"]|\\.)*\"

%%

"PRINT"      { return PRINT; }
"IF"         { return IF; }
"THEN"       { return THEN; }
"ENDIF"      { return ENDIF; }
"WHILE"      { return WHILE; }
"DO"         { return DO; }
"ENDWHILE"   { return ENDWHILE; }
"FOR"        { return FOR; }
"TO"         { return TO; }
"NEXT"       { return NEXT; }
"INPUT"      { return INPUT; }
"LET"        { return LET; }
"="          { return '='; }
"=="         { return EQ; }
"!="         { return NE; }
"<"          { return '<'; }
">"          { return '>'; }
"<="         { return LE; }
">="         { return GE; }
"+"          { return '+'; }
"-"          { return '-'; }
"*"          { return '*'; }
"/"          { return '/'; }
"("          { return '('; }
")"          { return ')'; }
{NUMBER}     { yylval.num = atoi(yytext); return NUMBER; }
{STRING}     { yylval.str = strdup(yytext); return STRING; }
{IDENTIFIER} { yylval.id = strdup(yytext); return IDENTIFIER; }
[ \t\n]      ;  // Ignorar espaços em branco
.            { return yytext[0]; }

%%
