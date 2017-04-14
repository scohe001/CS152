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
  string*	str_val;
}

%start	input 

%token	<str_val>	FUNCTION
%token	<str_val>	BEGIN_PARAMS
%token	<str_val>	END_PARAMS
%token	<str_val>	BEGIN_LOCALS
%token	<str_val>	END_LOCALS
%token	<str_val>	BEGIN_BODY
%token	<str_val>	END_BODY
%token	<str_val>	INTEGER
%token	<str_val>	ARRAY
%token	<str_val>	OF
%token	<str_val>	IF
%token	<str_val>	THEN
%token	<str_val>	ENDIF
%token	<str_val>	ELSE
%token	<str_val>	WHILE
%token	<str_val>	DO
%token	<str_val>	BEGINLOOP
%token	<str_val>	ENDLOOP
%token	<str_val>	CONTINUE
%token	<str_val>	READ
%token	<str_val>	WRITE
%token	<str_val>	AND
%token	<str_val>	OR
%token	<str_val>	NOT
%token	<str_val>	TRU
%token	<str_val>	FALS
%token	<str_val>	RETURN


%token	<str_val>	SUB
%token	<str_val>	ADD
%token	<str_val>	MULT
%token	<str_val>	DIV
%token	<str_val>	MOD

%token	<str_val>	EQ
%token	<str_val>	NEQ
%token	<str_val>	LT
%token	<str_val>	GT
%token	<str_val>	LTE
%token	<str_val>	GTE

%token	<str_val>	SEMICOLON
%token	<str_val>	COLON
%token	<str_val>	COMMA
%token	<str_val>	L_PAREN
%token	<str_val>	R_PAREN
%token	<str_val>	L_SQUARE_BRACKET
%token	<str_val>	R_SQUARE_BRACKET
%token	<str_val>	ASSIGN

%token	<str_val>	IDENT
%token	<int_val>	NUMBER


%type	<int_val>	exp
%type	<str_val>	function
%type	<str_val>	dec_block

%left	PLUS
%left	MULT
%left	DIV
%left	POW

%%

input:		/* empty */
		IDENT 		{ cout << *((std::string*)$1) << endl; }
		| function	{ cout << "Function!" << endl; }
		;

function:	FUNCTION IDENT SEMICOLON BEGIN_PARAMS dec_block END_PARAMS BEGIN_LOCALS dec_block END_LOACLS BEGIN_BODY state_block END_BODY	{ cout << "Function things!" << endl; }
		;

dec_block:	declaration SEMICOLON { cout << "declaration!" << endl; }
		| dec_block dec_block {}

exp:		NUMBER		{ $$ = $1; cout << $1 << endl; }
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
