example ?= all

run:
	@mkdir -p ./output
	@cat ./examples/$(example).bas | ./compiladores > ./output/$(example).py
	@echo ""
	@echo "---------------------"
	@echo ""
	@echo "Output writen to \"./output/$(example).py\" and logged below:"
	@echo ""
	@cat ./output/$(example).py

make run-docker:
	@mkdir -p ./output
	@cat ./examples/$(example).bas | ./compiladores > ./output/$(example).py
	@echo "Output:"
	@echo ""
	@cat ./output/$(example).py

build:
	bison -d -Wcounterexamples bison.y
	flex flex.l
	gcc -o compiladores bison.tab.c lex.yy.c codegen.c -lfl

clean:
	rm -f bison.tab.c 
	rm -f bison.tab.h
	rm -f lex.yy.c
	rm -f compiladores
