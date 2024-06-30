# Relatório

## Membros

- `Bruno Barros Mello`
- `Rodrigo Gonçalves Correa`


## Atuação de cada membro

A implementação do trabalho foi realizada praticamente por inteiro em pair programming no discord, com algumas exceções de momentos em que um membro pegou o projeto para atuar em determinada tarefa assíncronamente.

## Estrutura do projeto

O projeto possui a seguinte estrutura:

- `Makefile`, com comandos para compilação, execução e limpeza do projeto.
- `Dockerfile` com a configuração de um container para rodar o projeto, caso não possa instalar as dependências para rodar localmente.
- Arquivos `flex.l` e `bison.y`, com a implementação do trabalho prática.
- Arquivos auxiliares `codegen.h` e `codegen.c`, para geração de código de saída.
- Pasta `examples` com alguns arquivos de exemplo de programas na linguagem BASIC, para utilizar na entrada do programa.
- Pasta `output` que armazena os arquivos de saída gerados pelo compilador (ver makefile para mais detalhes).

## Como rodar o projeto

### Nativamente

- Instalar dependências:
    - `sudo apt install flex bison`
- Compilar o projeto:
    - `make build`
- Rodar o projeto:
    - `make run`
- Se preferir, pode especificar qual caso de exemplo deseja rodar (`ls -l ./examples` para ver as opções disponíveis):
    - `make run EXAMPLE=for`

## Limitações e pendências

