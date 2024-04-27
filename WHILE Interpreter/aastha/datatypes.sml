structure DataTypes=
    struct
    type Ident = string
    datatype Val = Int_value of int | Bool_value of bool
    datatype Start  = Program of Block
    and     Block = Block of DeclarationSeq * Command_D list
    and     DeclarationSeq = DeclarationSeq of VarDecls option * ProcDecls option
    and     VarDecls = VarDecls of  ((string list) * Type)
    and     Type = Int | Bool  | rational
    and     ProcDecls = ProcDecls of ProcDef*ProcDecls list
    and     ProcDef = ProcDef of string * Block
    and     Command_D   = AssignmentCmd of string*Expression | Read of string | Print of string | Call of string | IfThenElse of Expression*(Command_D list)*(Command_D list) | While of Expression*(Command_D list)
    and     Expression =  Ident of string | Plus of Expression*Expression | Minus of Expression*Expression | Multiply of Expression*Expression | Divide of Expression*Expression | Modulus of Expression*Expression |Num of string | Uni_minus of Expression |  Lt of Expression*Expression | Gt of Expression*Expression | Gte of Expression*Expression |Lte of Expression*Expression | Equal of Expression*Expression | Ne of Expression*Expression | And of Expression*Expression | Or of Expression*Expression | Negation of Expression | tt | ff | Rplus of Expression*Expression | Rminus of Expression*Expression | Rmultiply of Expression*Expression | Rdivide of Expression*Expression | Inverse of Expression | Make_rat of Expression | Show_rat of Expression | Rat of Expression | To_decimal of Expression | Show_decimal of Expression  |R of string*string | RUni_minus of Expression
    exception SemanticError;
    end