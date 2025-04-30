%{
#include <stdio.h>
%}

// Token definitions
COMMENT     //.*
FLOATDCL    f
INTDCL      i
PRINT       p
ID          [a-zA-Z][a-zA-Z0-9]*
ASSIGN      =
PLUS        \+
INUM        [0-9]+
FNUM        [0-9]+\.[0-9]+

%%
// Comment line
{COMMENT}       { printf("COMMENT\n"); }

// Declarations
{FLOATDCL}      { printf("floatdcl id\n"); }
{INTDCL}        { printf("intdcl id\n"); }

// Print command
{PRINT}         { printf("print id\n"); }

// Identifiers and assignments
{ID}            { printf("id "); yymore(); }
{ASSIGN}        { printf("assign "); yymore(); }
{INUM}          { printf("inum\n"); }
{FNUM}          { printf("fnum\n"); }
{PLUS}          { printf("plus "); }

// Whitespace and ignored tokens
[ \t\n]+        { /* Ignore whitespace */ }

.               { printf("Unrecognized token: %s\n", yytext); }

%%

int main(int argc, char **argv) {
    if (argc != 2) {
        printf("Usage: %s <input_file>\n", argv[0]);
        return 1;
    }

    FILE *file = fopen(argv[1], "r");
    if (!file) {
        perror("Error opening file");
        return 1;
    }

    yyin = file;
    yylex();
    fclose(file);
    return 0;
}

int yywrap() {
    return 1;
}
