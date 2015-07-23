grammar Calc;

calcfile: formset section*;

formset :
    'FORM' 'FORMSET' '(' ID ')'  '.' form ';';
form: ID;

section :
    'SECTION' ID ';'
	decl?
	block;


block: BEGIN stmt* END ';' ;

stmt: assign | call ';' | ret | ctrlStruct ;

assign: full_id LET expr ';' ;


call :full_id '(' argList ')';



expr : expr op=('/' | '*') expr #DivMul
	| expr op=('+' | '-') expr #AddSub
	| expr op=('>' | '<' | '<=' | '>=' | '=') expr #Predicate
	| expr '*' '(' expr '/' '100' ')' #PercentageOf
	| full_id #VarRef
	| call #FunctionCall
	| 'MAX' '(' argList ')' #Max
	| LITERAL #Literal
	| '(' expr ')'  #Parens
	;
argList : (expr (',' expr)*)? ;

decl : VAR declList*;
declList : (varDecl (',' varDecl)*)? ':' r_type ';' ;

varDecl: ID;
r_type: ID;
ctrlStruct : ifStruct | loopStruct ;
	
ifStruct : IF expr THEN (block|stmt) elseStruct?;

elseStruct: ELSE  (block|stmt);

loopStruct : DO (WHILE preCond=expr)?
				stmt*
			LOOP (WHILE postCond=expr)? ;
			
ret : RETURN expr? ';' ;
			
function: retType=full_id fnName=full_id formParList
		  decl?
          block ;
          
formParList : '(' formPar* ')' ;

formPar : r_type name=full_id (LET defaultVal=expr)? ;
		   
LITERAL : INT
	| STRING
	| BOOLEAN
	;

VAR: 'var'|'VAR';
IF : 'if'|'IF' ;
ELSE : 'else' |'ELSE';
THEN : 'then'|'THEN' ;
DO : 'do';
WHILE : 'while';
LOOP : 'loop';
RETURN : 'return';
WS : [ \t\r\n]+ -> skip ;
BEGIN : 'BEGIN'|'begin' ;
END : 'END'|'end' ;
LET : ':=' ;
full_id : ID sub_id?;
sub_id : '.' ID;
ID : [a-zA-Z_][a-zA-Z_0-9]* ;

INT : '-'? [0-9]+ ('.' [0-9]+)?;
STRING : '"' .*? '"' ;
BOOLEAN : 'true' | 'false' ;


COMMENT
    :   '/*' .*? '*/' -> skip
    ;
