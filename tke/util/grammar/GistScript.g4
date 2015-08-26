grammar GistScript;

gistscript: section*;

section :
    (const|var|tmp) alt? '=' gist;

alt: '|' (const|var|tmp);

gist:ID  '(' params (',' params)* ','?  ')';

params: name ':' (param_list|param);

param_list: '[' param (',' param)* ','? ']';

param:  named_param? (const|var|constant|tmp)  alt?;

named_param: name ':' ;

name: ID;
var : ID;
tmp: '@' ID;
const: '$' ID;

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

