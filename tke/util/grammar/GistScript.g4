grammar GistScript;

gistscript: section*;

section :
    (var|tmp|const) alt? '=' gist;

alt: '|' (var|tmp|const);

gist:ID  '(' params (',' params)* ','?  ')';

params: name ':' (param_list|param);

param_list: '[' param (',' param)* ','? ']';

param:  named_param? (var|constant|tmp|const)  alt?;

named_param: name ':' ;

name: ID;
var : ID;
tmp: '@' ID;
const: '/Constants/' ID;

ID: [a-zA-Z_0-9\/\.]+ ;
constant: CONSTANT;
CONSTANT: [0-9]+ ;

WS : [ \t\r\n]+ -> skip ;

COMMENT
    :   '/*' .*? '*/' -> skip
    ;

LINE_COMMENT
    :   '//' ~[\r\n]* -> skip
    ;

