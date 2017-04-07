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
#include <string.h>
%}

	int num_ints = 0, num_ops = 0, num_parens = 0, num_equals = 0;
	int num_lines = 0, num_chars = 0;

DIGIT		[0-9]
FLOAT		{DIGIT}*\.{DIGIT}+
ID		[a-z][a-z0-9]*
WHITESPACE	[ \n\t]

%%
{DIGIT}+ { /*int*/
	num_ints++;
	printf("NUMBER %d\n", atoi(yytext));
	num_chars += strlen(yytext);
}

{FLOAT} { /*float*/
	printf("FLOAT %s\n", yytext);
	num_chars += strlen(yytext);
}

({FLOAT}|{DIGIT}+)[eE][+-]?{DIGIT}+ { /*exponent*/
	printf("EXPONENT %s\n", yytext);
	num_chars += strlen(yytext);
}

\+	printf("PLUS\n"); num_ops++, num_chars++;
\-	printf("MINUS\n"); num_ops++, num_chars++;
\*	printf("MULT\n"); num_ops++, num_chars++;
\/	printf("DIV\n"); num_ops++, num_chars++;
\(	printf("L_PAREN\n"); num_parens++, num_chars++;
\)	printf("R_PAREN\n"); num_parens++, num_chars++;
=	printf("EQUAL\n"); num_equals++, num_chars++;

\n	num_lines++, num_chars = 0;

{WHITESPACE}	;

.	printf("***ERROR LINE %d, CHAR %d***\n", num_lines, num_chars);

%%

main()
{
  yylex();
  printf("Integers = %d, Operators = %d, Parenthesis = %d, Equals = %d\n", 
		num_ints, num_ops, num_parens, num_equals);
}

