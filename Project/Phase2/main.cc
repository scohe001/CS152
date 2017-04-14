/* main.cc */

#include "heading.h"

extern std::map<std::string, int> reserved;
extern std::map<std::string, int> arithmetic;
extern std::map<std::string, int> comparison;
extern std::map<std::string, int> other;

// prototype of bison-generated parser function
int yyparse();
void setup_maps();

int main(int argc, char **argv)
{
  setup_maps();
  if ((argc > 1) && (freopen(argv[1], "r", stdin) == NULL))
  {
    cerr << argv[0] << ": File " << argv[1] << " cannot be opened.\n";
    exit( 1 );
  }
  
  yyparse();

  return 0;
}

void setup_maps() {
  /***reserved***/
  reserved["function"] = FUNCTION;
  reserved["beginparams"] = BEGIN_PARAMS;
  reserved["endparams"] = END_PARAMS;
  reserved["beginlocals"] = BEGIN_LOCALS;
  reserved["endlocals"] = END_LOCALS;
  reserved["beginbody"] = BEGIN_BODY;
  reserved["endbody"] = END_BODY;
  reserved["integer"] = INTEGER;
  reserved["array"] = ARRAY;
  reserved["of"] = OF;
  reserved["if"] = IF;
  reserved["then"] = THEN;
  reserved["endif"] = ENDIF;
  reserved["else"] = ELSE;
  reserved["while"] = WHILE;
  reserved["do"] = DO;
  reserved["beginloop"] = BEGINLOOP;
  reserved["endloop"] = ENDLOOP;
  reserved["continue"] = CONTINUE;
  reserved["read"] = READ;
  reserved["write"] = WRITE;
  reserved["and"] = AND;
  reserved["or"] = OR;
  reserved["not"] = NOT;
  reserved["true"] = TRU;
  reserved["false"] = FALS;
  reserved["return"] = RETURN;
  /***arithmetic***/
  arithmetic["-"] = SUB;
  arithmetic["+"] = ADD;
  arithmetic["*"] = MULT;
  arithmetic["/"] = DIV;
  arithmetic["%"] = MOD;
  /***comparison***/
  comparison["=="] = EQ;
  comparison["<>"] = NEQ;
  comparison["<"] = LT;
  comparison[">"] = GT;
  comparison["<="] = LTE;
  comparison[">="] = GTE;
  /***other***/
  other[";"] = SEMICOLON;
  other[":"] = COLON;
  other[","] = COMMA;
  other["("] = L_PAREN;
  other[")"] = R_PAREN;
  other["["] = L_SQUARE_BRACKET;
  other["]"] = R_SQUARE_BRACKET;
  other[":="] = ASSIGN;
}
