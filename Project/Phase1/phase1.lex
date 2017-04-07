/* 
 * Sample Scanner2: 
 * Description: Count the number of characters and the number of lines 
 *              from standard input
 * Usage: (1) $ flex sample2.lex
 *        (2) $ gcc lex.yy.c -lfl
 *        (3) $ ./a.out
 *            stdin> whatever you like
 *	      stdin> Ctrl-D
 * Questions: Is it ok if we do not indent the first line?
 *            What will happen if we remove the second rule?
 */

%{
/*needed for strlen*/
#include <cstring>
#include <unordered_map>
#include <string>
%}
	std::unordered_map<std::string, std::string> reserved;
	std::unordered_map<std::string, std::string> arithmetic;
	std::unordered_map<std::string, std::string> comparison;
	std::unordered_map<std::string, std::string> other;
	int num_lines = 0, num_chars = 0;

RESERVED	function|beginparams|endparams|beginlocals|endlocals|beginbody|endbody|endbody|integer|array|of|if|then|endif|else|while|do|beginloop|endloop|continue|read|write|and|or|not|true|false|return
ARITHMETIC	\-|\+|\*|\/|\%
COMPARISON	(==)|(<>)|<|>|(<=)|(>=)
OTHER		;|:|,|\(|\)|\[|\]|:=

DIGIT		[0-9]
LETTER		[a-zA-Z]
IDENTIFIER	{LETTER}+({LETTER}|{DIGIT})*(_*({LETTER}|{DIGIT})+)*
NUM_IDENTIFIER	({DIGIT}|_)+({LETTER}|{DIGIT})*(_({LETTER}|{DIGIT})+)*
US_IDENTIFIER	{LETTER}+({LETTER}|{DIGIT})*(_({LETTER}|{DIGIT})+)*_
FLOAT		{DIGIT}*\.{DIGIT}+
ID		[a-z][a-z0-9]*
WHITESPACE	[ \n\t]

/*{FLOAT} { /*float
	printf("FLOAT %s\n", yytext);
	num_chars += strlen(yytext);
}

({FLOAT}|{DIGIT}+)[eE][+-]?{DIGIT}+ { /*exponent
	printf("EXPONENT %s\n", yytext);
	num_chars += strlen(yytext);
} */

%%
##.* /*comment (doesn't capture newline at the end)*/ num_chars += strlen(yytext);

{RESERVED} 	printf("%s\n", reserved[yytext].c_str()); num_chars += strlen(yytext);
{ARITHMETIC} 	printf("%s\n", arithmetic[yytext].c_str()); num_chars += strlen(yytext);
{COMPARISON}	printf("%s\n", comparison[yytext].c_str()); num_chars += strlen(yytext);
{OTHER}		printf("%s\n", other[yytext].c_str()); num_chars += strlen(yytext);;

{DIGIT}+	printf("NUMBER %d\n", atoi(yytext)); num_chars += strlen(yytext);

{IDENTIFIER}	printf("IDENT %s\n", yytext); num_chars += strlen(yytext);



\n	num_lines++, num_chars = 0;

{WHITESPACE}	;

{NUM_IDENTIFIER} {
	printf("Error at line %d, column %d: identifier \"%s\" must begin with a letter",
		1 + num_lines, 1 + num_chars++, yytext);
	exit(0);
}

{US_IDENTIFIER} {
	printf("Error at line %d, column %d: identifier \"%s\" cannot end with an underscore\n",
		1 + num_lines, 1 + num_chars++, yytext);
	exit(0);
}

. {
	printf("Error at line %d, column %d: unrecognized symbol \"%s\"\n", 
		1 + num_lines, 1 + num_chars++, yytext);
	exit(0);
}

%%

void setup_maps();

main()
{
  setup_maps();
  yylex();
  /*printf("Integers = %d, Operators = %d, Parenthesis = %d, Equals = %d\n", 
		num_ints, num_ops, num_parens, num_equals);*/
}


void setup_maps() {
  /***reserved***/
  reserved["function"] = "FUNCTION";
  reserved["beginparams"] = "BEGIN_PARAMS";
  reserved["endparams"] = "END_PARAMS";
  reserved["beginlocals"] = "BEGIN_LOCALS";
  reserved["endlocals"] = "END_LOCALS";
  reserved["beginbody"] = "BEGIN_BODY";
  reserved["endbody"] = "END_BODY";
  reserved["integer"] = "INTEGER";
  reserved["array"] = "ARRAY";
  reserved["of"] = "OF";
  reserved["if"] = "IF";
  reserved["then"] = "THEN";
  reserved["endif"] = "ENDIF";
  reserved["else"] = "ELSE";
  reserved["while"] = "WHILE";
  reserved["do"] = "DO";
  reserved["beginloop"] = "BEGINLOOP";
  reserved["endloop"] = "ENDLOOP";
  reserved["continue"] = "CONTINUE";
  reserved["read"] = "READ";
  reserved["write"] = "WRITE";
  reserved["and"] = "AND";
  reserved["or"] = "OR";
  reserved["not"] = "NOT";
  reserved["true"] = "TRUE";
  reserved["false"] = "FALSE";
  reserved["return"] = "RETURN";
  /***arithmetic***/
  arithmetic["-"] = "SUB";
  arithmetic["+"] = "ADD";
  arithmetic["*"] = "MULT";
  arithmetic["/"] = "DIV";
  arithmetic["%"] = "MOD";
  /***comparison***/
  comparison["=="] = "EQ";
  comparison["<>"] = "NEQ";
  comparison["<"] = "LT";
  comparison[">"] = "GT";
  comparison["<="] = "LTE";
  comparison[">="] = "GTE";
  /***other***/
  other[";"] = "SEMICOLON";
  other[":"] = "COLON";
  other[","] = "COMMA";
  other["("] = "L_PAREN";
  other[")"] = "R_PAREN";
  other["["] = "L_SQUARE_BRACKET";
  other["]"] = "R_SQUARE_BRACKET";
  other[":="] = "ASSIGN";
}

