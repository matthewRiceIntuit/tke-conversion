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

multicopy_accum: full_id '[' start_index '..' end_index ']' ;

start_index: LITERAL|expr;
end_index: LITERAL|expr;



expr : expr op=('/' | '*') expr #DivMul
	| expr op=('+' | '-') expr #AddSub
	| expr op=('and' | 'or') expr #Logic
	| expr op=('>' | '<' | '<=' | '>=' | '=') expr #Predicate
	| LITERAL #Literal
	| NOT expr #Not
	| full_id #VarRef
	| boolean  #Bool
	| call #FunctionCall
	| multicopy_accum #MultiCopyAccumulate
	| 'MAX' '(' argList ')' #Max
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

ctrlStruct : ifStruct | loopStruct | forloopstruct ;
	
ifStruct : IF expr THEN (block|stmt|dumbblock|assign) elseStruct?;

elseStruct: ELSE  (block|stmt);

loopStruct : DO (WHILE preCond=expr)?
				stmt*
			LOOP (WHILE postCond=expr)? ;

forloopstruct: FOR ID ':=' expr TO expr DO  (block|stmt);


			
ret : RETURN expr? ';' ;
			
function: retType=full_id fnName=full_id formParList
		  vardecl?
          block ;
          
formParList : '(' formPar* ')' ;

formPar : r_type name=full_id (LET defaultVal=expr)? ;
		   
LITERAL : INT
	| STRING
	;

fragment A:('a'|'A');
fragment B:('b'|'B');
fragment C:('c'|'C');
fragment D:('d'|'D');
fragment E:('e'|'E');
fragment F:('f'|'F');
fragment G:('g'|'G');
fragment H:('h'|'H');
fragment I:('i'|'I');
fragment J:('j'|'J');
fragment K:('k'|'K');
fragment L:('l'|'L');
fragment M:('m'|'M');
fragment N:('n'|'N');
fragment O:('o'|'O');
fragment P:('p'|'P');
fragment Q:('q'|'Q');
fragment R:('r'|'R');
fragment S:('s'|'S');
fragment T:('t'|'T');
fragment U:('u'|'U');
fragment V:('v'|'V');
fragment W:('w'|'W');
fragment X:('x'|'X');
fragment Y:('y'|'Y');
fragment Z:('z'|'Z');

ARRAY: A R R A Y;
OF: O F;
VAR: V A R;
CONSTANT: C O N S T A N T;
IF : I F ;
ELSE : E L S E;
THEN : T H E N ;
SECTION: S E C T I O N;
DO : D O;
TO: T O;
FOR: F O R;
NOT: N O T;

WHILE : W H I L E;
LOOP : L O O P;
RETURN : R E T U R N;
WS : [ \t\r\n]+ -> skip ;
BEGIN : B E G I N;
END : E N D;
LET : ':=' ;
full_id : ID array_index? sub_id?;

sub_id : '.' ID array_index?;
ID : [a-zA-Z_][a-zA-Z_0-9]*;
array_index: ('[' expr ']');

INT : '-'? '.'? [0-9]+ ('.' [0-9]+)?;
STRING : '"' .*? '"' ;

boolean : TRUE|FALSE|CHECKED;
TRUE:  T R U E;
FALSE:  F A L S E;
CHECKED: C H E C K E D;

COMMENT
    :   '/*' .*? '*/' -> skip
    ;

LINE_COMMENT
    :   '//' ~[\r\n]* -> skip
    ;

