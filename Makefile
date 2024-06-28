run:
	cat ./example.bas | ./compiler

build:
	bison -d -Wcounterexamples bison.y
	flex flex.l
	gcc -o compiler bison.tab.c lex.yy.c codegen.c -lfl


clean:
	rm bison.tab.c 
	rm bison.tab.h
	rm lex.yy.c
	rm compiler
