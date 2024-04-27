Grammar used

start : blk
blk : decseq cmdseq
decseq : [vardec] [procdec]
procdec : procdef ; { procdec ;} ; 
procdef : procedure Ident blk
vardec : typedec Ident { , Ident} ;
typedec : Int | Bool | rational
cmdseq : {{command;}}
command : read Ident | print Ident | Ident := expression | call Ident | If expression then cmdseq else cmdseq fi | while expression do cmdseq od
expression : Ident | (expression) | expression + expression | expression - expression | expression * expression | expression    .+. expression | expression .-. expression | expression .*. expression | expression ./. expression | expression > expression | expression < expression | expression = expression | expression <= expression | expression >= expression | expression <> expression | expression / expression | expression % expression | {digit} | ~ expression | rational | expression and expression | expression or expression | ! expression | tt | ff | make_rat (expression) | show_decimal(expression) | rat(expression)






Strategy for Parser
Here is an overview of what my parser does:
1-It defines three data types: Bool, Int, and rational.
2-It defines an exception called "Duplicate_declaration" that is raised when a duplicate variable declaration is encountered.
3-It defines an exception called "TypeErrOr" that is raised when a variable of the wrong type is encountered.
4-It defines an exception called "Variable_Negation_defined" that is raised when a variable is referenced but not defined.
5-It defines three functions: Bool_check, int_check, and Rati_check. These functions take a type as an argument and return true if the type is Bool, Int, or rational, respectively.
6-It defines a function called "checkSameType" that takes two types as arguments and returns true if they are the same.
7-It defines a function called "insert" that takes a list of variable names and a type as arguments and inserts them into a hash table called "SymbolTable". If a variable with the same name already exists in the hash table, the "Duplicate_declaration" exception is raised.
8-It defines three functions called "check_int", "check_Bool", and "check_Rati" that take a variable name as an argument and check if it exists in the "SymbolTable" hash table. If it does, it checks its type and raises the "TypeErrOr" exception if it is of the wrong type.
9-It defines a function called "gettype" that takes a variable name as an argument and returns its type if it exists in the "SymbolTable" hash table. If it does not exist, the "Variable_Negation_defined" exception is raised.

Procedure
This is a ML-Yacc specification file that defines a parser for a programming language. The grammar specification includes several parsing techniques, including:

1. Terminal symbols: The grammar includes definitions for various terminal symbols such as Token_Plus, Token_Minus, Token_Equal, Token_Lparen, Token_Rparen, etc. These symbols are used to define the tokens that are recognized by the lexer.

2. Nonterminal symbols: The grammar also includes definitions for nonterminal symbols such as start, blk, declarationseq, commandseq, commands, command, typedecls, varlist, expr, procdecls, procdef, procdeclist, vardec,ls etc. These nonterminal symbols are used to define the various syntactic categories of the language.

3. Precedence rules: The grammar includes precedence rules for the various operators in the language. For example, the binary operators "+" and "-" have the same precedence level and are left-associative, while the unary operators "-" and "not" have a higher precedence level than the binary operators.

4. Semantic actions: The grammar includes semantic actions that are executed when certain productions are parsed. For example, the production "procdef: Token_Procedure Token_Ident blk" includes a semantic action that creates a procdef node in the AST.

5. Error handling: The grammar includes error handling rules that dictate how the parser should recover from syntax errors. For example, the %nodefault directive specifies that the parser should not generate default error messages when it encounters an unexpected token.

6. Symbol table management: The grammar includes functions for managing a symbol table, such as inserting entries into the table, looking up entries in the table, and checking the type of an entry. These functions are used to perform semantic analysis of the input program.