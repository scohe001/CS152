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

	int num_lines = 0, num_chars = 0, whitespace = 0;

DIGIT		[0-9]
ID		[a-z][a-z0-9]*
WHITESPACE	[ \n\t]

%%
{DIGIT}+ {
	printf("NUMBER %d\n", atoi(yytext));
}

\+	printf("PLUS\n");
\-	printf("MINUS\n");
\*	printf("MULT\n");
\/	printf("DIV\n");
\(	printf("L_PAREN\n");
\)	printf("R_PAREN\n");
=	printf("EQUAL\n");

{WHITESPACE}	++whitespace;
.	printf("***ERROR***\n");
%%

main()
{
  yylex();
  printf("# of lines = %d, # of chars = %d, whitespace = %d\n", 
		num_lines, num_chars, whitespace);
}

