grammar GistScript;

gistscript: section*;

section :
    var  '=' gist '(' params* ')' ;

gist:ID;

params: name ':' (param_list|param);

param_list: '[' (param ',')+ param? ']';

param:  named_param|var|constant;

named_param: name '=' (var|constant);

name: ID;
var : ID;
ID: [a-zA-Z_@][a-zA-Z_0-9/\.]* ;
constant: CONSTANT;
CONSTANT: [0-9]+ ;

WS : [ \t\r\n]+ -> skip ;

COMMENT
    :   '/*' .*? '*/' -> skip
    ;

LINE_COMMENT
    :   '//' ~[\r\n]* -> skip
    ;

