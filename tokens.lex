%{
#include <string.h>
#include <stdlib.h>  // Asegúrate de incluir esta biblioteca para malloc y free
#include <stdio.h>

# define INT 1
# define ID 2
# define IF 3
# define ELSE 4
# define WHILE 5
# define FOR 6
# define DOWHILE 7
# define SWITCHCASE 8
# define COLON 9
# define LPAREN 10
# define RPAREN 11
# define PLUS 12
# define MINUS 13
# define MULTIPLY 14
# define DIVIDE 15
# define LT 16
# define ASSIGN 17

typedef union {
    int pos;
    int ival;
    char* sval;
} YYSTYPE;

YYSTYPE yylval;

char* Cadena(char *s)
{
    char* p = (char*) malloc(strlen(s) + 1);
    strcpy(p, s);
    return p;
}

%}

/* lex definitions */
digits [0-9]+
%%

[ \r\t] { /* Ignorar espacios, tabulaciones y retornos de carro */ }

   /* reserved words */
if          { printf("Token IF\n"); return IF; }
else        { printf("Token ELSE\n"); return ELSE; }
while       { printf("Token WHILE\n"); return WHILE; }
for         { printf("Token FOR\n"); return FOR; }
do          { printf("Token DOWHILE\n"); return DOWHILE; }
switchcase  { printf("Token SWITCHCASE\n"); return SWITCHCASE; }
dowhile     { printf("Token DOWHILE\n"); return DOWHILE; }

   /* punctuations */
":" { printf("Token COLON\n"); return COLON; }
"(" { printf("Token LPAREN\n"); return LPAREN; }
")" { printf("Token RPAREN\n"); return RPAREN; }
"<" { printf("Token LT\n"); return LT; }
"=>" { printf("Token ASSIGN\n"); return ASSIGN; }

   /* aritmetic */
"+" { printf("Token PLUS\n"); return PLUS; }
"-" { printf("Token MINUS\n"); return MINUS; }
"*" { printf("Token MULTIPLY\n"); return MULTIPLY; }
"/" { printf("Token DIVIDE\n"); return DIVIDE; }

   /* Identifiers. */
[_a-zA-Z][a-zA-Z0-9]* {
    yylval.sval = Cadena(yytext);
    printf("Token ID: %s\n", yylval.sval);
    return ID;
}

   /* integers */
{digits} {
    yylval.ival = atoi(yytext);
    printf("Token INT: %d\n", yylval.ival);
    return INT;
}

   /* Cualquier otra cosa */
. {
    printf("Token desconocido: '%s'.\n", yytext);
}

%%

/* Este main es solamente de prueba.
    Más adelante, este main lo hará Yacc 
*/
int main(int argc, char *argv[]) {
    if (argc < 2) {
        printf("\n%s <archivo fuente>\n", argv[0]);
        return 0;
    }
    yyin = fopen(argv[1], "r");

    if (!yyin) {
        perror("Error al abrir el archivo");
        return 1;
    }

    while (yylex());

    fclose(yyin);
    return 0;
}
