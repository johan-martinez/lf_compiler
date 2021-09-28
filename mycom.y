%{
#include <stdio.h>   
#include <stdlib.h>
extern int yylex(void);
extern char *yytext;
void yyerror(char *s); 
extern FILE * yyin;
%}

%token TXT BOOL  NUM  LET  NAME_VAR IF ELSE WHILE  MATH COMPARATOR LOGIC KO KC BO BC EQ



%start Input
%%

Input: | Input Line;

Line:       | Variable  
            | Math  
            | Conditional 
            | Cycle 
            ;

Variable: LET NAME_VAR                            {printf("Valid code LET \n");} 
        | LET NAME_VAR EQ TXT                     {printf("Valid code LET \n");}
        | LET NAME_VAR EQ NUM                     {printf("Valid code LET \n");}
        | LET NAME_VAR EQ BOOL                    {printf("Valid code LET \n");}
        | NAME_VAR EQ TXT                         {printf("Valid code LET \n");}
        | NAME_VAR EQ NUM                         {printf("Valid code LET \n");}
        | NAME_VAR EQ BOOL                        {printf("Valid code LET \n");}
        | error                                   {printf("Sintax Error LET\n");};
        ;
        
      

Math: Expresion MATH Expresion             {printf("Valid code MATH \n");} 
        | BO Expresion BC { $$ = $2; }             
        | NUM { $$ = $1; } 
        | NAME_VAR { $$ = $1; }     
        | error {printf("Syntax Error Math \n");};
        ;


Conditional: IF BO Expresion BC KO Body KC        {printf("Valid code IF \n");} 
        | ELSE IF BO Expresion BC KO Body KC 
        | ELSE KO Body KC
        | error {printf("Syntax Error Conditional\n");};
        ;

        
Cycle  : WHILE BO Expresion BC KO Body KC         {printf("Valid code WHILE \n");} 
        | error {printf("Syntax Error While \n");};
        ;


Body:   Variable 
        | Math 
        ;

Expresion: Expresion COMPARATOR Expresion             
        | NUM {$$ = $1;}
        | NAME_VAR {$$ = $1;}
        | BOOL {$$ = $1;}
        | TXT {$$ = $1;}
        ;
%%


void yyerror(char *s){
  //  printf("Error: %s\n", s);
}

int main(int argc, char **argv) {
	// si hay argumentos cargue el archivo como entrada
    yyin = (argc > 1) ? fopen(argv[1],"r") : stdin;  
    yyparse();
    return 0;
}
