/* Mini Calculator */
/* calc.y */

%{
#include "heading.h"
int yyerror(char *s);
int yylex(void);
%}

%union{
  int		int_val;
  string*	op_val;
}

%start	input 

%token	<int_val>	INTEGER_LITERAL
%type	<int_val>	exp
%left	PLUS
%left	MULT
%left	DIV
%left	POW

%%

input:		/* empty */
		| exp	{ cout << "Result: " << $1 << endl; }
		;

exp:		INTEGER_LITERAL	{ $$ = $1; cout << $1 << endl; }
		| exp PLUS exp	{ $$ = $1 + $3; cout << $1 << " + " << $3 << endl; }
		| exp MULT exp	{ $$ = $1 * $3; cout << $1 << " * " << $3 << endl; }
		| exp DIV exp	{ $$ = $1 / $3; cout << $1 << " / " << $3 << endl; }
		| exp POW exp	{ $$ = pow($1, $3); cout << $1 << " ^ " << $3 << endl; }
		;

%%

int yyerror(string s)
{
  extern int yylineno;	// defined and maintained in lex.c
  extern char *yytext;	// defined and maintained in lex.c
  
  cerr << "ERROR: " << s << " at symbol \"" << yytext;
  cerr << "\" on line " << yylineno << endl;
  exit(1);
}

int yyerror(char *s)
{
  return yyerror(string(s));
}
