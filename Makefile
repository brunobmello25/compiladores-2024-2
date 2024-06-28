run:
	cat ./example.bas | ./compiler

build:
	bison -d -Wcounterexamples basic.y
	flex basic.l
	gcc -o compiler basic.tab.c lex.yy.c codegen.c -lfl


clean:
	rm basic.tab.c 
	rm basic.tab.h
	rm lex.yy.c
	rm compiler
