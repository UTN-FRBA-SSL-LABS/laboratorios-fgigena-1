%{
#include <stdio.h>
#include <stdlib.h>

int  yylex(void);
void yyerror(const char *msg) { fprintf(stderr, "Error: %s\n", msg); }
%}

%token NUM

%%

input:
    /* vacío */
  | input linea
  ;

linea:
    exp '\n'   { printf("= %d\n", $1); }   /* TODO 5 resuelto */
  ;

exp:
    exp '+' term   { $$ = $1 + $3; }
  | exp '-' term   { $$ = $1 - $3; }       /* TODO 1 resuelto */
  | term           { $$ = $1; }
  ;

term:
    term '*' factor { $$ = $1 * $3; }      /* TODO 2 resuelto */
  | term '/' factor { $$ = $1 / $3; }      /* TODO 3 resuelto */
  | factor          { $$ = $1; }
  ;

factor:
    NUM             { $$ = $1; }
  | '(' exp ')'    { $$ = $2; }            /* TODO 4 resuelto */
  ;

%%

int main(void) {
    return yyparse();
}