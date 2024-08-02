%{
#include <string.h>
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



typedef union  {
	int pos;
	int ival;
	char* sval;
} YYSTYPE;

YYSTYPE yylval;

char* Cadena(char *s)
{
    char* p = (char*) malloc(strlen(s)+1);
    strcpy(p,s);
    return p;
}

%}


/* lex definitions */
digits [0-9]+
%%

[ \r\t] {continue;}

   /* reserved words */

if          {return IF;}
else        {return ELSE;}
while       {ECHO; return WHILE;}
for  	    {return FOR;}
do          {return DOWHILE;}
swicthcase  {return SWITCHCASE;}
dowhile     {return DOWHILE;}


   /* punctuations */
":" {return COLON;}
"(" {return LPAREN;}
")" {return RPAREN;}
"<" {return LT;}
"=>" {return ASSIGN;}


   /* aritmetic */
"+" {return PLUS;}
"-" {return MINUS;}
"*" {return MULTIPLY;}
"/" {return DIVIDE;}


   /* Identifiers. */
[_a-zA-Z][a-zA-Z0-9]* {yylval.sval=Cadena(yytext); return ID;}


   /* integers */

{digits}	 {yylval.ival=atoi(yytext); return INT;}


   /* Cualquier otra cosa */
.	 { printf("\nToken desconocido: '%s'.\n", yytext); }


%%

/* Este main es solamente de prueba.
    Más adelante, este mian lo hará Yacc 
*/
int main(int argc, char *argv[]) {
    if (argc < 2) {
        printf("\n%s <archivo fuente>\n", argv[0]);
        return 0;
    }
    yyin = fopen(argv[1], "r");

    while(yylex());

    fclose(yyin);
}