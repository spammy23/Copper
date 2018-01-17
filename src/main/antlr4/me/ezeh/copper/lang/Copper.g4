grammar Copper;

programme: info? (methodDeclaration | expression)*;
expression:
    methodCall
    | bool
    | literal
    | ifStatement
    | variable
    | expression BINOP expression
    | expression POSTUNOP
    | PREUNOP expression
    | returnStatement; // Passing off a statement like this as an expression probably won't do well

info: INFO OPENBRACE (variable ':' literal)* CLOSEBRACE;
methodDeclaration: METHOD method_name=NAME (OPENBRACKET variable* CLOSEBRACE | NAME*) (OPENBRACE expression* CLOSEBRACE | EQUALS expression);
methodCall: method_name=NAME OPENBRACKET (expression (',' expression)*)? CLOSEBRACKET;
bool: TRUE | FALSE;
literal: DecimalLiteral | HexLiteral | StringLiteral;
ifStatement: IF (expression|OPENBRACKET expression CLOSEBRACKET) (expression | OPENBRACE expression* CLOSEBRACE) elseStatement?;
elseStatement: ELSE (expression| OPENBRACKET expression CLOSEBRACKET) (expression| OPENBRACE expression* CLOSEBRACE);
variable: NAME;
returnStatement: RETURN expression;
RETURN: 'return';
METHOD: 'method';
INFO: 'info';
BINOP:
    [+*/-]
    |'and'
    | 'or';

POSTUNOP: '!';
PREUNOP: '-';
EQUALS: ':';

TRUE: 'true';
FALSE: 'false';
IF: 'if';
ELSE: 'else';
WHILE: 'while';
OPENBRACKET: '(';
CLOSEBRACKET: ')';
OPENBRACE: '{';
CLOSEBRACE: '}';
NAME: [A-z_]+;
StringLiteral: '"' StringChar*? '"';
DecimalLiteral: DecimalNumber;
HexLiteral: '0x' HexNumber;

fragment Escape: SimpleEscape | HexEscape;
fragment SimpleEscape: '\\' ['"?abfnrtv\\];

fragment HexEscape: '\\x' HexNumber;

fragment DecimalNumber: ('0' | [1-9] [0-9]*);
fragment HexNumber: HexDigit+;

fragment HexDigit: [0-9] | [a-f] | [A-F];
fragment StringChar: ~[\r\n"];

SEMICOLON: ';' -> skip;
WHITESPACE: [\t\r\n ] -> skip;
COMMENT: ( ('//' | '#') ~[\r\n]* | '/*' .*? '*/') -> skip;
