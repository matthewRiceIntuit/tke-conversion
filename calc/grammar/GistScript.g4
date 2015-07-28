grammar GistScript;

gistscript: section*;

section :
    (var|tmp) alt? '=' gist;

alt: '|' (var|tmp);

gist:ID  '(' params* ')';

params: name ':' (param_list|param);

param_list: '[' (param ',')+ param? ']';

param:  named_param? (var|constant|tmp)  alt?;

named_param: name ':' ;

name: ID;
var : ID;
tmp: '@' ID;
ID: [a-zA-Z_][a-zA-Z_0-9/\.]* ;
constant: CONSTANT;
CONSTANT: [0-9]+ ;

WS : [ \t\r\n]+ -> skip ;

COMMENT
    :   '/*' .*? '*/' -> skip
    ;

LINE_COMMENT
    :   '//' ~[\r\n]* -> skip
    ;

