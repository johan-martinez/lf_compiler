bison -d mycom.y
flex mycom.l
gcc mycom.tab.c lex.yy.c -lfl -o mycom.exe 
