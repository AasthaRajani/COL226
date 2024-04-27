open DataTypes
val SymbolTable : (string, Type) HashTable.hash_table =
    HashTable.mkTable (HashString.hashString, op=) (42, Fail "IdentIfier Negation found") ;

exception Duplicate_declaRation of string ;
exception TypeErrOr ;
exception Variable_Negation_defiNed ;


fun Bool_check (typeToBeChecked : Type) =
    if ( typeToBeChecked = Bool ) then true else false ;

fun int_check (typeToBeChecked : Type) =
    if ( typeToBeChecked = Int ) then true else false ;

fun Rati_check (typeToBeChecked : Type) =
    if ( typeToBeChecked = rational ) then true else false ;


fun checkSameType ( A : Type , B : Type ) = (A = B);
fun insert( idList :string list, idType : Type) =
    if ( null idList ) then ()
    else ( if isSome (HashTable.find SymbolTable (hd idList)) then raise Duplicate_declaRation( hd idList )
    else
            HashTable.insert SymbolTable ( hd idList, idType ) ; insert ( tl idList, idType) );

fun check_int( id: string) =
    if( isSome (HashTable.find SymbolTable id))
    then
        case ( HashTable.lookup SymbolTable id ) of Int => () | Bool => ( raise TypeErrOr) | rational => ( raise TypeErrOr)
    else
        raise Variable_Negation_defiNed ;

fun check_Bool( id : string ) =
    if( isSome (HashTable.find SymbolTable id))
    then
        case ( HashTable.lookup SymbolTable id ) of Int => ( raise TypeErrOr) | Bool => () | rational => ( raise TypeErrOr)
    else
        raise Variable_Negation_defiNed ;

fun check_Rati( id : string ) =
    if( isSome (HashTable.find SymbolTable id))
    then
        case ( HashTable.lookup SymbolTable id ) of Int => ( raise TypeErrOr) | Bool => (raise TypeErrOr) | rational => ()
    else
        raise Variable_Negation_defiNed ;

fun gettype ( id : string ) =
    if( isSome (HashTable.find SymbolTable id))
    then
        HashTable.lookup SymbolTable id
    else
        raise Variable_Negation_defiNed ;




%%
%name Ration

%term  Token_Lt | Token_From_decimal | Token_Id | Token_Rational | Token_Var | Token_Plus | Token_Uni_minus | Token_Minus | Token_Multiply | Token_Divide | Token_Modulus | Token_Equal | Token_Ne | Token_Gt | Token_Gte | Token_LT | Token_Lte | Token_And | Token_Or | Token_Negation | Token_Assign | Token_Int | Token_Bool | Token_Read | Token_If | Token_then | Token_else | Token_fi | Token_while | Token_do | Token_od | Token_tt | Token_ff  | Token_Semicolon | Token_Comma | Token_Lbrace | Token_Rbrace | Token_Lparen | Token_Rparen | Token_Ident of string | Token_Num of string | Token_EOF | Token_Show_rat | Token_Make_rat | Token_Left_comm | Token_Right_comm | Token_Show_decimal | Token_To_decimal | Token_Rplus | Token_Rminus| Token_Rmultiply | Token_Rdivide | Token_Inverse | Token_Rati | Token_Call | Token_Procedure | Token_Print | Token_Rat  | Token_R of string*string

%nonterm start of DataTypes.Start | blk of DataTypes.Block | decseq of DataTypes.DeclarationSeq | cmdseq of DataTypes.Command_D list | Commands of DataTypes.Command_D list | Command of DataTypes.Command_D | typedec of DataTypes.Type | varlist of string list | expr of  DataTypes.Type*DataTypes.Expression | procdec of DataTypes.ProcDecls | procdef of DataTypes.ProcDef | procdeclist of DataTypes.ProcDecls list | vardec of DataTypes.VarDecls

%pos int
%eop Token_EOF
%noshift Token_EOF
%nodefault
%verbose

%right Token_Assign
%left Token_Or
%left Token_And
%left Token_Equal Token_Ne
%left Token_Lte Token_LT Token_Gte Token_Gt
%left Token_Plus Token_Minus Token_Rplus Token_Rminus
%left Token_Multiply Token_Divide Token_Modulus Token_Rmultiply Token_Rdivide
%left Token_Rat Token_Make_rat Token_Show_decimal Token_To_decimal Token_Inverse Token_Show_rat
%right Token_Uni_minus Token_Negation
%left Token_Lparen Token_Rparen

%arg (filename): string

%%

start: blk (HashTable.clear SymbolTable ; DataTypes.Program(blk))
blk: decseq cmdseq (DataTypes.Block(decseq,cmdseq))
decseq: vardec procdec  (DataTypes.DeclarationSeq(SOME vardec,SOME procdec)) | vardec (DataTypes.DeclarationSeq(SOME vardec,NONE)) | procdec (DataTypes.DeclarationSeq(NONE,SOME procdec)) | (DataTypes.DeclarationSeq(NONE,NONE))

procdec: procdef Token_Semicolon procdeclist (DataTypes.ProcDecls( procdef,procdeclist))
procdeclist: procdec Token_Semicolon procdeclist (procdec :: procdeclist )  | (([]))
procdef: Token_Procedure Token_Ident blk (DataTypes.ProcDef(Token_Ident, blk))

vardec: typedec varlist Token_Semicolon (( insert( varlist , typedec) ; DataTypes.VarDecls(varlist ,typedec)))
varlist: Token_Ident (([Token_Ident])) | Token_Ident Token_Comma varlist ((Token_Ident::varlist))
typedec: Token_Int ((Int)) | Token_Bool ((Bool)) | Token_Rati ((rational))
cmdseq: Token_Lbrace Commands Token_Rbrace ((Commands))
Commands: Command Token_Semicolon Commands ((Command::Commands)) | (([]))

Command: Token_Read Token_Ident ((DataTypes.Read(Token_Ident))) | Token_Print Token_Ident ((DataTypes.Print(Token_Ident)))
        | Token_Ident Token_Assign expr (( if (checkSameType( gettype Token_Ident, #1 expr)) then () else raise TypeErrOr; DataTypes.AssignmentCmd(Token_Ident,  #2 expr )))
        | Token_Call Token_Ident ((DataTypes.Call(Token_Ident)))
        | Token_If expr Token_then cmdseq Token_else cmdseq Token_fi (( if (Bool_check (#1 expr)) then () else raise TypeErrOr ; DataTypes.IfThenElse( #2 expr, cmdseq, cmdseq)))
        | Token_while expr Token_do cmdseq Token_od (( if (Bool_check (#1 expr)) then () else raise TypeErrOr ; DataTypes.While( #2 expr, cmdseq )))

expr:  Token_Ident (( gettype Token_Ident , DataTypes.Ident(Token_Ident))) | Token_Lparen expr Token_Rparen ((expr))
        | expr Token_Plus expr (( if int_check( #1  expr1) andalso int_check( #1 expr2) then () else raise TypeErrOr ;(Int , DataTypes.Plus(#2 expr1 , #2 expr2))))
        | expr Token_Minus expr (( if int_check( #1  expr1) andalso int_check( #1 expr2) then () else raise TypeErrOr ;(Int , DataTypes.Minus(#2 expr1 , #2 expr2))))
        | expr Token_Multiply expr ((if int_check( #1  expr1) andalso int_check( #1 expr2) then () else raise TypeErrOr ; (Int , DataTypes.Multiply(#2 expr1 , #2 expr2))))
        | expr Token_Divide expr (( if int_check( #1  expr1) andalso int_check( #1 expr2) then () else raise TypeErrOr ;(Int , DataTypes.Divide(#2 expr1 , #2 expr2))))
        | expr Token_Modulus expr (( if int_check( #1  expr1) andalso int_check( #1 expr2) then () else raise TypeErrOr ;(Int , DataTypes.Modulus(#2 expr1 , #2 expr2))))
        | Token_Num (( Int , DataTypes.Num(Token_Num) ))
        | expr Token_Rplus expr (( if Rati_check( #1  expr1) andalso Rati_check( #1 expr2) then () else raise TypeErrOr ;(rational , DataTypes.Rplus(#2 expr1 , #2 expr2))))
        | expr Token_Rminus expr (( if Rati_check( #1  expr1) andalso Rati_check( #1 expr2) then () else raise TypeErrOr ;(rational , DataTypes.Rminus(#2 expr1 , #2 expr2))))
        | expr Token_Rmultiply expr ((if Rati_check( #1  expr1) andalso Rati_check( #1 expr2) then () else raise TypeErrOr ; (rational , DataTypes.Rmultiply(#2 expr1 , #2 expr2))))
        | expr Token_Rdivide expr (( if Rati_check( #1  expr1) andalso Rati_check( #1 expr2) then () else raise TypeErrOr ;(rational , DataTypes.Rdivide(#2 expr1 , #2 expr2))))
        | Token_Uni_minus expr ((if Rati_check(#1 expr) then () else raise TypeErrOr ;(rational , DataTypes.RUni_minus( #2 expr))))
        | Token_R (( rational, DataTypes.R(Token_R) ))
        | expr Token_Lte expr (( if checkSameType( #1 expr1, #1 expr2) then () else raise TypeErrOr ; (Bool, DataTypes.Lte( #2 expr1, #2 expr2))))
        | expr Token_LT expr (( if checkSameType( #1 expr1, #1 expr2) then () else raise TypeErrOr ; (Bool, DataTypes.Lt( #2 expr1, #2 expr2))))
        | expr Token_Gte expr (( if checkSameType( #1 expr1, #1 expr2) then () else raise TypeErrOr ; (Bool, DataTypes.Gte( #2 expr1, #2 expr2))))
        | expr Token_Gt expr (( if checkSameType( #1 expr1, #1 expr2) then () else raise TypeErrOr ; (Bool, DataTypes.Gt( #2 expr1, #2 expr2))))
        | expr Token_Equal expr (( if checkSameType( #1 expr1, #1 expr2) then () else raise TypeErrOr ; (Bool, DataTypes.Equal( #2 expr1, #2 expr2))))
        | expr Token_Ne expr (( if checkSameType( #1 expr1, #1 expr2) then () else raise TypeErrOr ; (Bool, DataTypes.Ne( #2 expr1, #2 expr2))))
        | expr Token_And expr ((if Bool_check( #1  expr1) andalso Bool_check( #1 expr2) then () else raise TypeErrOr ;(Bool , DataTypes.And(#2 expr1 , #2 expr2))))
        | expr Token_Or expr ((if Bool_check( #1  expr1) andalso Bool_check( #1 expr2) then () else raise TypeErrOr ;(Bool , DataTypes.Or(#2 expr1 , #2 expr2))))
        | Token_Negation expr ((if Bool_check( #1  expr) then () else raise TypeErrOr ;(Bool , DataTypes.Negation(#2 expr))))
        | Token_tt ((Bool,tt))
        | Token_ff ((Bool,ff))