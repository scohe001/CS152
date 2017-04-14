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
#include "heading.h"
#include <cstring>
#include <string>
%}

	std::map<std::string, std::string> reserved;
	std::map<std::string, std::string> arithmetic;
	std::map<std::string, std::string> comparison;
	std::map<std::string, std::string> other;
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

