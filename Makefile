example ?= example

run: build
	cat ./examples/$(example).bas | ./compiler

build:
	bison -d -Wcounterexamples bison.y
	flex flex.l
	gcc -o compiler bison.tab.c lex.yy.c codegen.c -lfl

clean:
	rm -f bison.tab.c 
	rm -f bison.tab.h
	rm -f lex.yy.c
	rm -f compiler
