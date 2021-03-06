grammar Copper;

programme: info? (classDeclaration | methodDeclaration | listener | expression)*;
expression:
    methodCall
    | bool
    | literal
    | ifStatement
    | assignment
    | successful
    | unsuccessful
    | returnStatement // Passing off a statement like this as an expression probably won't do well
    | variable
    | operand=expression postunop=BANG // Factorial-ise
    | operand=expression postunop=PERCENT // Percentage-isation
    | preunop=MINUS operand=expression // Mathematical Negation
    | preunop=NOT operand=expression // Logical not
    | left=expression binop=MULTIPLY right=expression // Multiplication
    | left=expression binop=DIVIDE right=expression // Division
    | left=expression binop=PERCENT right=expression  // Modulo Division
    | left=expression binop=ADD right=expression // Addition
    | left=expression binop=MINUS right=expression // Subtraction
    | left=expression binop=EQUALSEQUALS right=expression // Equality
    | left=expression binop=AND right=expression // Logical and
    | left=expression binop=OR right=expression // Logical or
    ;

classDeclaration: CLASS class_name=NAME OPENBRACE init? (classDeclaration | methodDeclaration)* CLOSEBRACE; // listeners inside?
assignment: variable EQUALS expression;
listener: ON event_name=NAME ( (variable EQUALS expression (COMMA variable EQUALS expression)*)? | OPENBRACKET (variable EQUALS expression (COMMA variable EQUALS expression)*)? CLOSEBRACKET)? ( OPENBRACE expression* CLOSEBRACE | expression);
info: INFO OPENBRACE (variable COLON literal)* CLOSEBRACE;
methodDeclaration: STATIC?
     FUNCTION? method_name=NAME
        (OPENBRACKET (variable (COMMA variable)*)? CLOSEBRACKET | variable*) // args
        (OPENBRACE expression* CLOSEBRACE)
    | FUNCTION method_name=NAME
        (OPENBRACKET (variable (COMMA variable)*)? CLOSEBRACKET | variable*) // args
        EQUALS expression
    ;
methodCall: method_name=NAME (OPENBRACKET (expression (COMMA expression)*)? CLOSEBRACKET | expression (COMMA expression)*);
bool: TRUE | FALSE;
literal: DecimalLiteral | HexLiteral | StringLiteral;
ifStatement: IF (expression|OPENBRACKET expression CLOSEBRACKET) THEN? (expression | OPENBRACE expression* CLOSEBRACE) elseStatement?;
elseStatement: ELSE (expression| OPENBRACE expression* CLOSEBRACE);
variable: NAME;
returnStatement: RETURN expression;
successful: SUCCESSFUL | SUCCEEDED;
unsuccessful: UNSUCCESSFUL | FAILED;
init: INIT OPENBRACE expression* CLOSEBRACE;

INIT: 'init';
CLASS: 'class';
SUCCESSFUL: 'successful';
UNSUCCESSFUL: 'unsuccessful';
SUCCEEDED:'succeeded';
FAILED: 'failed';
THEN: 'then';
COMMA: ',';
COLON: ':';
ON: 'on';
RETURN: 'return';
FUNCTION: 'function' | 'fun';
INFO: 'info';
STATIC: 'static';

MULTIPLY: '*';
DIVIDE: '/';
ADD: '+';
MINUS: '-';

AND: '&&' | 'and';
OR: 'or' | '||';
NOT: '!' | 'not';

PERCENT: '%';
BANG: '!';

EQUALSEQUALS: '=='; // hehe
EQUALS: '=';

TRUE: 'true';
FALSE: 'false';
IF: 'if';
ELSE: 'else';
WHILE: 'while';
OPENBRACKET: '(';
CLOSEBRACKET: ')';
OPENBRACE: '{';
CLOSEBRACE: '}';
NAME: [A-z_.]+;
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
