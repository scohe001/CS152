# Makefile

OBJS	= bison.o lex.o main.o

CC	= g++
CFLAGS	= -std=c++11 -g

minl:		$(OBJS)
		$(CC) $(CFLAGS) $(OBJS) -o minl -lfl

lex.o:		lex.c
		$(CC) $(CFLAGS) -c lex.c -o lex.o

lex.c:		minl.lex 
		flex minl.lex
		cp lex.yy.c lex.c

bison.o:	bison.c
		$(CC) $(CFLAGS) -c bison.c -o bison.o

bison.c:	minl.y
		bison -d -v minl.y
		cp minl.tab.c bison.c
		cmp -s minl.tab.h tok.h || cp minl.tab.h tok.h

main.o:		main.cc
		$(CC) $(CFLAGS) -c main.cc -o main.o

lex.o yac.o main.o	: heading.h
lex.o main.o		: tok.h

clean:
	rm -f *.o *~ lex.c lex.yy.c bison.c tok.h minl.tab.c minl.tab.h minl.output minl
