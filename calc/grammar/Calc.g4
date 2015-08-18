grammar Calc;

calcfile: formset constdecl? vardecl? section*;

formset :
    'FORM' ID  '.' form ';';

form: ID;

section :
    SECTION ID ';'
	vardecl?
	block;


block: BEGIN stmt* END ';' ;
dumbblock:  BEGIN stmt* END  ;

stmt: assign ';' | call ';' | ret | ctrlStruct ;

assign: full_id LET expr ;


call :ID '(' argList ')';



expr : expr op=('/' | '*') expr #DivMul
	| expr op=('+' | '-') expr #AddSub
	| expr op=('and' | 'or') expr #Logic
	| expr op=('>' | '<' | '<=' | '>=' | '=') expr #Predicate
	| expr '*' '(' expr '/' '100' ')' #PercentageOf
	| NOT expr #Not
	| full_id #VarRef
	| call #FunctionCall
	| 'MAX' '(' argList ')' #Max
	| LITERAL #Literal
	| '(' expr ')'  #Parens
	;
argList : (expr (',' expr)*)? ;

vardecl : VAR declList*;
constdecl : CONSTANT constdeclList*;

declList : (varDecl (',' varDecl)*)? ':' r_type ';' ;
constdeclList: varDecl '='  LITERAL ';';

varDecl: ID;
r_type: arrayDecl? ID;

arrayDecl: ARRAY '[' LITERAL ']' OF;

ctrlStruct : ifStruct | loopStruct ;
	
ifStruct : IF expr THEN (block|stmt|dumbblock|assign) elseStruct?;

elseStruct: ELSE  (block|stmt);

loopStruct : DO (WHILE preCond=expr)?
				stmt*
			LOOP (WHILE postCond=expr)? ;
			
ret : RETURN expr? ';' ;
			
function: retType=full_id fnName=full_id formParList
		  vardecl?
          block ;
          
formParList : '(' formPar* ')' ;

formPar : r_type name=full_id (LET defaultVal=expr)? ;
		   
LITERAL : INT
	| STRING
	| BOOLEAN
	;

ARRAY: 'Array';
OF: 'of';
VAR: 'var'|'VAR';
CONSTANT: 'constant'| 'CONSTANT';
IF : 'if'|'IF'|'If' ;
ELSE : 'else' |'ELSE'|'Else';
THEN : 'then'|'THEN'|'Then' ;
SECTION: 'Section'|'SECTION';
DO : 'do';
NOT: 'not';

WHILE : 'while';
LOOP : 'loop';
RETURN : 'return';
WS : [ \t\r\n]+ -> skip ;
BEGIN : 'BEGIN'|'begin'|'Begin' ;
END : 'END'|'end' | 'End';
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

LINE_COMMENT
    :   '//' ~[\r\n]* -> skip
    ;

