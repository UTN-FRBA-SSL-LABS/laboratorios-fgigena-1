%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int  yylex(void);
void yyerror(const char *msg) { fprintf(stderr, "Error: %s\n", msg); }
%}

%token NUM
%token POW
%token UMINUS

%left '+' '-'       /* TODO 1 resuelto — menor precedencia */
%left '*' '/'       /* TODO 2 resuelto — mayor que + - */
%right POW          /* TODO 3 resuelto — mayor que * / */
%right UMINUS       /* TODO 4 resuelto — mayor de todas */

%%

input:
    /* vacío */
  | input linea
  ;

linea:
    exp '\n'   { printf("= %d\n", $1); }
  ;

exp:
    exp '+' exp           { $$ = $1 + $3; }
  | exp '-' exp           { $$ = $1 - $3; }
  | exp '*' exp           { $$ = $1 * $3; }
  | exp '/' exp           { $$ = $1 / $3; }
  | exp POW exp           { $$ = (int)pow($1, $3); }
  | '-' exp %prec UMINUS  { $$ = -$2; }   /* TODO 5 resuelto */
  | '(' exp ')'           { $$ = $2; }
  | NUM                   { $$ = $1; }
  ;

%%

int main(void) {
    return yyparse();
}
