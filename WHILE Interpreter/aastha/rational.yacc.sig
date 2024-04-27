signature Ration_TOKENS =
sig
type ('a,'b) token
type svalue
val Token_R: (string*string) *  'a * 'a -> (svalue,'a) token
val Token_Rat:  'a * 'a -> (svalue,'a) token
val Token_Print:  'a * 'a -> (svalue,'a) token
val Token_Procedure:  'a * 'a -> (svalue,'a) token
val Token_Call:  'a * 'a -> (svalue,'a) token
val Token_Rati:  'a * 'a -> (svalue,'a) token
val Token_Inverse:  'a * 'a -> (svalue,'a) token
val Token_Rdivide:  'a * 'a -> (svalue,'a) token
val Token_Rmultiply:  'a * 'a -> (svalue,'a) token
val Token_Rminus:  'a * 'a -> (svalue,'a) token
val Token_Rplus:  'a * 'a -> (svalue,'a) token
val Token_To_decimal:  'a * 'a -> (svalue,'a) token
val Token_Show_decimal:  'a * 'a -> (svalue,'a) token
val Token_Right_comm:  'a * 'a -> (svalue,'a) token
val Token_Left_comm:  'a * 'a -> (svalue,'a) token
val Token_Make_rat:  'a * 'a -> (svalue,'a) token
val Token_Show_rat:  'a * 'a -> (svalue,'a) token
val Token_EOF:  'a * 'a -> (svalue,'a) token
val Token_Num: (string) *  'a * 'a -> (svalue,'a) token
val Token_Ident: (string) *  'a * 'a -> (svalue,'a) token
val Token_Rparen:  'a * 'a -> (svalue,'a) token
val Token_Lparen:  'a * 'a -> (svalue,'a) token
val Token_Rbrace:  'a * 'a -> (svalue,'a) token
val Token_Lbrace:  'a * 'a -> (svalue,'a) token
val Token_Comma:  'a * 'a -> (svalue,'a) token
val Token_Semicolon:  'a * 'a -> (svalue,'a) token
val Token_ff:  'a * 'a -> (svalue,'a) token
val Token_tt:  'a * 'a -> (svalue,'a) token
val Token_od:  'a * 'a -> (svalue,'a) token
val Token_do:  'a * 'a -> (svalue,'a) token
val Token_while:  'a * 'a -> (svalue,'a) token
val Token_fi:  'a * 'a -> (svalue,'a) token
val Token_else:  'a * 'a -> (svalue,'a) token
val Token_then:  'a * 'a -> (svalue,'a) token
val Token_If:  'a * 'a -> (svalue,'a) token
val Token_Read:  'a * 'a -> (svalue,'a) token
val Token_Bool:  'a * 'a -> (svalue,'a) token
val Token_Int:  'a * 'a -> (svalue,'a) token
val Token_Assign:  'a * 'a -> (svalue,'a) token
val Token_Negation:  'a * 'a -> (svalue,'a) token
val Token_Or:  'a * 'a -> (svalue,'a) token
val Token_And:  'a * 'a -> (svalue,'a) token
val Token_Lte:  'a * 'a -> (svalue,'a) token
val Token_LT:  'a * 'a -> (svalue,'a) token
val Token_Gte:  'a * 'a -> (svalue,'a) token
val Token_Gt:  'a * 'a -> (svalue,'a) token
val Token_Ne:  'a * 'a -> (svalue,'a) token
val Token_Equal:  'a * 'a -> (svalue,'a) token
val Token_Modulus:  'a * 'a -> (svalue,'a) token
val Token_Divide:  'a * 'a -> (svalue,'a) token
val Token_Multiply:  'a * 'a -> (svalue,'a) token
val Token_Minus:  'a * 'a -> (svalue,'a) token
val Token_Uni_minus:  'a * 'a -> (svalue,'a) token
val Token_Plus:  'a * 'a -> (svalue,'a) token
val Token_Var:  'a * 'a -> (svalue,'a) token
val Token_Rational:  'a * 'a -> (svalue,'a) token
val Token_Id:  'a * 'a -> (svalue,'a) token
val Token_From_decimal:  'a * 'a -> (svalue,'a) token
val Token_Lt:  'a * 'a -> (svalue,'a) token
end
signature Ration_LRVALS=
sig
structure Tokens : Ration_TOKENS
structure ParserData:PARSER_DATA
sharing type ParserData.Token.token = Tokens.token
sharing type ParserData.svalue = Tokens.svalue
end
