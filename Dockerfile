FROM gcc:latest

RUN apt-get update && \
    apt-get install -y flex bison

# Set the working directory inside the container
WORKDIR /usr/src/app

COPY . .

RUN bison -d bison.y
RUN flex flex.l
RUN gcc -o compiladores bison.tab.c lex.yy.c codegen.c -lfl

ENTRYPOINT ["make", "run-docker"]

CMD ["example=all"]
