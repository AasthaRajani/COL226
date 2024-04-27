structure T = Tokens

type pos = int
type svalue = T.svalue
type ('a, 'b) token = ('a, 'b) T.token
type lexresult = (svalue,pos) token
type lexarg = string
type arg = lexarg

val line = ref 1;
val column = ref 0;
val eolpos = ref 0;

val  eof = fn filename => (line := 1; column := 0; T.Token_EOF (!line , !column));
fun increase a  = a := !a + 1;

%%
%header (functor RationLexFun (structure Tokens : Ration_TOKENS));
%arg (filename: string);
alpha=[A-Za-z];
digit=[0-9];
nz=[1-9];
sign=[~+];
Rational=[sign]{digit}* | [sign]{digit}*[.]{digit}*[(]{digit}+[)] | [(][sign]{digit}+[,]{digit}nz{digit}[)];
ws = [\ \t];
eol = ("\013\010" | "\010" | "\013");
%%
{ws}* => (continue ());
{eol} => (increase line; eolpos := yypos+size yytext; continue ());


"if" => (column:=yypos-(!eolpos); T.Token_If(!line,!column));
"then" => (column:=yypos-(!eolpos); T.Token_then(!line,!column));
"else" => (column:=yypos-(!eolpos); T.Token_else(!line,!column));
"fi" => (column:=yypos-(!eolpos); T.Token_fi(!line,!column));
"while" => (column:=yypos-(!eolpos); T.Token_while(!line,!column));
"od" => (column:=yypos-(!eolpos); T.Token_od(!line,!column));
"do" => (column:=yypos-(!eolpos); T.Token_do(!line,!column));
"integer" => (column:=yypos-(!eolpos); T.Token_Int(!line,!column));
"boolean" => (column:=yypos-(!eolpos); T.Token_Bool(!line,!column));
"rational" => (column:=yypos-(!eolpos); T.Token_Rational(!line,!column));
"read" => (column:=yypos-(!eolpos); T.Token_Read(!line,!column));
"print" => (column:=yypos-(!eolpos); T.Token_Print(!line,!column));
"call" => (column:=yypos-(!eolpos); T.Token_Call(!line,!column));
"procedure" => (column:=yypos-(!eolpos); T.Token_Procedure(!line,!column));
"var" => (column:=yypos-(!eolpos); T.Token_Var(!line,!column));
"tt" => (column:=yypos-(!eolpos); T.Token_tt(!line,!column));
"ff" => (column:=yypos-(!eolpos); T.Token_ff(!line,!column));
"(" => (column:=yypos-(!eolpos); T.Token_Lparen(!line,!column));
")" => (column:=yypos-(!eolpos); T.Token_Rparen(!line,!column));
"{" => (column:=yypos-(!eolpos); T.Token_Lbrace(!line,!column));
"}" => (column:=yypos-(!eolpos); T.Token_Rbrace(!line,!column));
"," => (column:=yypos-(!eolpos); T.Token_Comma(!line,!column));
";" => (column:=yypos-(!eolpos); T.Token_Semicolon(!line,!column));
".+." => (column:=yypos-(!eolpos); T.Token_Rplus(!line,!column));
".-." => (column:=yypos-(!eolpos); T.Token_Rminus(!line,!column));
".*." => (column:=yypos-(!eolpos); T.Token_Rmultiply(!line,!column));
"./." => (column:=yypos-(!eolpos); T.Token_Rdivide(!line,!column));
"=" => (column:=yypos-(!eolpos); T.Token_Equal(!line,!column));
"<=" => (column:=yypos-(!eolpos); T.Token_Lte(!line,!column));
">=" => (column:=yypos-(!eolpos); T.Token_Gte(!line,!column));
"<" => (column:=yypos-(!eolpos); T.Token_Gt(!line,!column));
">" => (column:=yypos-(!eolpos); T.Token_Lt(!line,!column));
"<>" => (column:=yypos-(!eolpos); T.Token_Ne(!line,!column));
":=" => (column:=yypos-(!eolpos); T.Token_Assign(!line,!column));
"||" => (column:=yypos-(!eolpos); T.Token_Or(!line,!column));
"&&" => (column:=yypos-(!eolpos); T.Token_And(!line,!column));
"+" => (column:=yypos-(!eolpos); T.Token_Plus(!line,!column));
"-" => (column:=yypos-(!eolpos); T.Token_Minus(!line,!column));
"*" => (column:=yypos-(!eolpos); T.Token_Multiply(!line,!column));
"/" => (column:=yypos-(!eolpos); T.Token_Divide(!line,!column));
"%" => (column:=yypos-(!eolpos); T.Token_Modulus(!line,!column));
"!" => (column:=yypos-(!eolpos); T.Token_Negation(!line,!column));
"~" => (column:=yypos-(!eolpos); T.Token_Uni_minus(!line,!column));
"make_rat" => (column:=yypos-(!eolpos); T.Token_Make_rat(!line,!column));
"rat" => (column:=yypos-(!eolpos); T.Token_Rat(!line,!column));
"showRat" => (column:=yypos-(!eolpos); T.Token_Show_rat(!line,!column));
"showDecimal" => (column:=yypos-(!eolpos); T.Token_Show_decimal(!line,!column));
"fromDecimal" => (column:=yypos-(!eolpos); T.Token_From_decimal(!line,!column));
"toDecimal" => (column:=yypos-(!eolpos); T.Token_To_decimal(!line,!column));
"inverse" => (column:=yypos-(!eolpos); T.Token_Inverse(!line,!column));
"(*" => (column:=yypos-(!eolpos); T.Token_Left_comm(!line,!column));
"*)" => (column:=yypos-(!eolpos); T.Token_Right_comm(!line,!column));
([+]?)({digit}){digit}* => ( T.Token_Num( yytext , !line , !column ) ) ;

rati => (column:=yypos-(!eolpos); T.Token_R(("",""),!line,!column));
[A-Za-z][A-Za-z0-9]* => (column:=yypos-(!eolpos);T.Token_Ident(yytext,!line,!column));

. => (print ("Unknown Token found at " ^ (Int.toString (!line)) ^ ": <" ^ yytext ^ ">. Continuing.\n"); continue());