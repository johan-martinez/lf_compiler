%{
  #include "mycom.tab.h"
%}

NUMBER      [0-9]+(\.[0-9]+)?
TEXT        '.{0,15}'
BOOLEAN     ("true"|"false")
NAME_VAR    ([a-z]+([a-zA-Z0-9]+)?){1,10}
MATH_OPE    ("+"|"-"|"*"|"/")
COM_OPE     (<|>|>=|<=|==|!=)
LOG_OPE     ("&&"|"||"|"!")

%%

{NUMBER}        return NUM;
{TEXT}          return TXT;
{BOOLEAN}       return BOOL;
"if"            return IF;
"else"          return ELSE;
"while"         return WHILE;
"let"           return LET;
{MATH_OPE}      return MATH;
{NAME_VAR}      return NAME_VAR;
{COM_OPE} 	return COMPARATOR;
{LOG_OPE} 	return LOGIC;
"{"             return KO;
"}"             return KC; 
"("             return BO;
")"             return BC;    
"="             return EQ;    
\n              return EOL;
[ \t]+          {}
.                {printf("Lexical Error %s\n", yytext);}
%%
