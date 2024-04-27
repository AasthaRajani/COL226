functor RationLrValsFun(structure Token : TOKEN)
 : sig structure ParserData : PARSER_DATA
       structure Tokens : Ration_TOKENS
   end
 = 
struct
structure ParserData=
struct
structure Header = 
struct
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





end
structure LrTable = Token.LrTable
structure Token = Token
local open LrTable in 
val table=let val actionRows =
"\
\\001\000\006\000\126\000\008\000\126\000\009\000\126\000\010\000\126\000\
\\011\000\126\000\012\000\126\000\013\000\126\000\014\000\126\000\
\\015\000\126\000\016\000\126\000\017\000\126\000\018\000\126\000\
\\019\000\126\000\026\000\126\000\030\000\126\000\034\000\126\000\
\\039\000\126\000\049\000\126\000\050\000\126\000\051\000\126\000\
\\052\000\126\000\000\000\
\\001\000\006\000\127\000\008\000\127\000\009\000\127\000\010\000\127\000\
\\011\000\127\000\012\000\127\000\013\000\127\000\014\000\127\000\
\\015\000\127\000\016\000\127\000\017\000\127\000\018\000\127\000\
\\019\000\127\000\026\000\127\000\030\000\127\000\034\000\127\000\
\\039\000\127\000\049\000\127\000\050\000\127\000\051\000\127\000\
\\052\000\127\000\000\000\
\\001\000\006\000\128\000\008\000\128\000\009\000\069\000\010\000\068\000\
\\011\000\067\000\012\000\128\000\013\000\128\000\014\000\128\000\
\\015\000\128\000\016\000\128\000\017\000\128\000\018\000\128\000\
\\019\000\128\000\026\000\128\000\030\000\128\000\034\000\128\000\
\\039\000\128\000\049\000\128\000\050\000\128\000\051\000\055\000\
\\052\000\054\000\000\000\
\\001\000\006\000\129\000\008\000\129\000\009\000\069\000\010\000\068\000\
\\011\000\067\000\012\000\129\000\013\000\129\000\014\000\129\000\
\\015\000\129\000\016\000\129\000\017\000\129\000\018\000\129\000\
\\019\000\129\000\026\000\129\000\030\000\129\000\034\000\129\000\
\\039\000\129\000\049\000\129\000\050\000\129\000\051\000\055\000\
\\052\000\054\000\000\000\
\\001\000\006\000\130\000\008\000\130\000\009\000\130\000\010\000\130\000\
\\011\000\130\000\012\000\130\000\013\000\130\000\014\000\130\000\
\\015\000\130\000\016\000\130\000\017\000\130\000\018\000\130\000\
\\019\000\130\000\026\000\130\000\030\000\130\000\034\000\130\000\
\\039\000\130\000\049\000\130\000\050\000\130\000\051\000\130\000\
\\052\000\130\000\000\000\
\\001\000\006\000\131\000\008\000\131\000\009\000\131\000\010\000\131\000\
\\011\000\131\000\012\000\131\000\013\000\131\000\014\000\131\000\
\\015\000\131\000\016\000\131\000\017\000\131\000\018\000\131\000\
\\019\000\131\000\026\000\131\000\030\000\131\000\034\000\131\000\
\\039\000\131\000\049\000\131\000\050\000\131\000\051\000\131\000\
\\052\000\131\000\000\000\
\\001\000\006\000\132\000\008\000\132\000\009\000\132\000\010\000\132\000\
\\011\000\132\000\012\000\132\000\013\000\132\000\014\000\132\000\
\\015\000\132\000\016\000\132\000\017\000\132\000\018\000\132\000\
\\019\000\132\000\026\000\132\000\030\000\132\000\034\000\132\000\
\\039\000\132\000\049\000\132\000\050\000\132\000\051\000\132\000\
\\052\000\132\000\000\000\
\\001\000\006\000\133\000\008\000\133\000\009\000\133\000\010\000\133\000\
\\011\000\133\000\012\000\133\000\013\000\133\000\014\000\133\000\
\\015\000\133\000\016\000\133\000\017\000\133\000\018\000\133\000\
\\019\000\133\000\026\000\133\000\030\000\133\000\034\000\133\000\
\\039\000\133\000\049\000\133\000\050\000\133\000\051\000\133\000\
\\052\000\133\000\000\000\
\\001\000\006\000\134\000\008\000\134\000\009\000\069\000\010\000\068\000\
\\011\000\067\000\012\000\134\000\013\000\134\000\014\000\134\000\
\\015\000\134\000\016\000\134\000\017\000\134\000\018\000\134\000\
\\019\000\134\000\026\000\134\000\030\000\134\000\034\000\134\000\
\\039\000\134\000\049\000\134\000\050\000\134\000\051\000\055\000\
\\052\000\054\000\000\000\
\\001\000\006\000\135\000\008\000\135\000\009\000\069\000\010\000\068\000\
\\011\000\067\000\012\000\135\000\013\000\135\000\014\000\135\000\
\\015\000\135\000\016\000\135\000\017\000\135\000\018\000\135\000\
\\019\000\135\000\026\000\135\000\030\000\135\000\034\000\135\000\
\\039\000\135\000\049\000\135\000\050\000\135\000\051\000\055\000\
\\052\000\054\000\000\000\
\\001\000\006\000\136\000\008\000\136\000\009\000\136\000\010\000\136\000\
\\011\000\136\000\012\000\136\000\013\000\136\000\014\000\136\000\
\\015\000\136\000\016\000\136\000\017\000\136\000\018\000\136\000\
\\019\000\136\000\026\000\136\000\030\000\136\000\034\000\136\000\
\\039\000\136\000\049\000\136\000\050\000\136\000\051\000\136\000\
\\052\000\136\000\000\000\
\\001\000\006\000\137\000\008\000\137\000\009\000\137\000\010\000\137\000\
\\011\000\137\000\012\000\137\000\013\000\137\000\014\000\137\000\
\\015\000\137\000\016\000\137\000\017\000\137\000\018\000\137\000\
\\019\000\137\000\026\000\137\000\030\000\137\000\034\000\137\000\
\\039\000\137\000\049\000\137\000\050\000\137\000\051\000\137\000\
\\052\000\137\000\000\000\
\\001\000\006\000\138\000\008\000\138\000\009\000\138\000\010\000\138\000\
\\011\000\138\000\012\000\138\000\013\000\138\000\014\000\138\000\
\\015\000\138\000\016\000\138\000\017\000\138\000\018\000\138\000\
\\019\000\138\000\026\000\138\000\030\000\138\000\034\000\138\000\
\\039\000\138\000\049\000\138\000\050\000\138\000\051\000\138\000\
\\052\000\138\000\000\000\
\\001\000\006\000\139\000\008\000\139\000\009\000\139\000\010\000\139\000\
\\011\000\139\000\012\000\139\000\013\000\139\000\014\000\139\000\
\\015\000\139\000\016\000\139\000\017\000\139\000\018\000\139\000\
\\019\000\139\000\026\000\139\000\030\000\139\000\034\000\139\000\
\\039\000\139\000\049\000\139\000\050\000\139\000\051\000\139\000\
\\052\000\139\000\000\000\
\\001\000\006\000\148\000\008\000\148\000\009\000\148\000\010\000\148\000\
\\011\000\148\000\012\000\148\000\013\000\148\000\014\000\148\000\
\\015\000\148\000\016\000\148\000\017\000\148\000\018\000\148\000\
\\019\000\148\000\026\000\148\000\030\000\148\000\034\000\148\000\
\\039\000\148\000\049\000\148\000\050\000\148\000\051\000\148\000\
\\052\000\148\000\000\000\
\\001\000\006\000\149\000\008\000\149\000\009\000\149\000\010\000\149\000\
\\011\000\149\000\012\000\149\000\013\000\149\000\014\000\149\000\
\\015\000\149\000\016\000\149\000\017\000\149\000\018\000\149\000\
\\019\000\149\000\026\000\149\000\030\000\149\000\034\000\149\000\
\\039\000\149\000\049\000\149\000\050\000\149\000\051\000\149\000\
\\052\000\149\000\000\000\
\\001\000\006\000\150\000\008\000\150\000\009\000\150\000\010\000\150\000\
\\011\000\150\000\012\000\150\000\013\000\150\000\014\000\150\000\
\\015\000\150\000\016\000\150\000\017\000\150\000\018\000\150\000\
\\019\000\150\000\026\000\150\000\030\000\150\000\034\000\150\000\
\\039\000\150\000\049\000\150\000\050\000\150\000\051\000\150\000\
\\052\000\150\000\000\000\
\\001\000\006\000\071\000\008\000\070\000\009\000\069\000\010\000\068\000\
\\011\000\067\000\012\000\140\000\013\000\140\000\014\000\140\000\
\\015\000\140\000\016\000\140\000\017\000\140\000\018\000\140\000\
\\019\000\140\000\026\000\140\000\030\000\140\000\034\000\140\000\
\\039\000\140\000\049\000\057\000\050\000\056\000\051\000\055\000\
\\052\000\054\000\000\000\
\\001\000\006\000\071\000\008\000\070\000\009\000\069\000\010\000\068\000\
\\011\000\067\000\012\000\141\000\013\000\141\000\014\000\141\000\
\\015\000\141\000\016\000\141\000\017\000\141\000\018\000\141\000\
\\019\000\141\000\026\000\141\000\030\000\141\000\034\000\141\000\
\\039\000\141\000\049\000\057\000\050\000\056\000\051\000\055\000\
\\052\000\054\000\000\000\
\\001\000\006\000\071\000\008\000\070\000\009\000\069\000\010\000\068\000\
\\011\000\067\000\012\000\142\000\013\000\142\000\014\000\142\000\
\\015\000\142\000\016\000\142\000\017\000\142\000\018\000\142\000\
\\019\000\142\000\026\000\142\000\030\000\142\000\034\000\142\000\
\\039\000\142\000\049\000\057\000\050\000\056\000\051\000\055\000\
\\052\000\054\000\000\000\
\\001\000\006\000\071\000\008\000\070\000\009\000\069\000\010\000\068\000\
\\011\000\067\000\012\000\143\000\013\000\143\000\014\000\143\000\
\\015\000\143\000\016\000\143\000\017\000\143\000\018\000\143\000\
\\019\000\143\000\026\000\143\000\030\000\143\000\034\000\143\000\
\\039\000\143\000\049\000\057\000\050\000\056\000\051\000\055\000\
\\052\000\054\000\000\000\
\\001\000\006\000\071\000\008\000\070\000\009\000\069\000\010\000\068\000\
\\011\000\067\000\012\000\144\000\013\000\144\000\014\000\064\000\
\\015\000\063\000\016\000\062\000\017\000\061\000\018\000\144\000\
\\019\000\144\000\026\000\144\000\030\000\144\000\034\000\144\000\
\\039\000\144\000\049\000\057\000\050\000\056\000\051\000\055\000\
\\052\000\054\000\000\000\
\\001\000\006\000\071\000\008\000\070\000\009\000\069\000\010\000\068\000\
\\011\000\067\000\012\000\145\000\013\000\145\000\014\000\064\000\
\\015\000\063\000\016\000\062\000\017\000\061\000\018\000\145\000\
\\019\000\145\000\026\000\145\000\030\000\145\000\034\000\145\000\
\\039\000\145\000\049\000\057\000\050\000\056\000\051\000\055\000\
\\052\000\054\000\000\000\
\\001\000\006\000\071\000\008\000\070\000\009\000\069\000\010\000\068\000\
\\011\000\067\000\012\000\066\000\013\000\065\000\014\000\064\000\
\\015\000\063\000\016\000\062\000\017\000\061\000\018\000\146\000\
\\019\000\146\000\026\000\146\000\030\000\146\000\034\000\146\000\
\\039\000\146\000\049\000\057\000\050\000\056\000\051\000\055\000\
\\052\000\054\000\000\000\
\\001\000\006\000\071\000\008\000\070\000\009\000\069\000\010\000\068\000\
\\011\000\067\000\012\000\066\000\013\000\065\000\014\000\064\000\
\\015\000\063\000\016\000\062\000\017\000\061\000\018\000\060\000\
\\019\000\147\000\026\000\147\000\030\000\147\000\034\000\147\000\
\\039\000\147\000\049\000\057\000\050\000\056\000\051\000\055\000\
\\052\000\054\000\000\000\
\\001\000\006\000\071\000\008\000\070\000\009\000\069\000\010\000\068\000\
\\011\000\067\000\012\000\066\000\013\000\065\000\014\000\064\000\
\\015\000\063\000\016\000\062\000\017\000\061\000\018\000\060\000\
\\019\000\059\000\026\000\075\000\049\000\057\000\050\000\056\000\
\\051\000\055\000\052\000\054\000\000\000\
\\001\000\006\000\071\000\008\000\070\000\009\000\069\000\010\000\068\000\
\\011\000\067\000\012\000\066\000\013\000\065\000\014\000\064\000\
\\015\000\063\000\016\000\062\000\017\000\061\000\018\000\060\000\
\\019\000\059\000\030\000\058\000\049\000\057\000\050\000\056\000\
\\051\000\055\000\052\000\054\000\000\000\
\\001\000\006\000\071\000\008\000\070\000\009\000\069\000\010\000\068\000\
\\011\000\067\000\012\000\066\000\013\000\065\000\014\000\064\000\
\\015\000\063\000\016\000\062\000\017\000\061\000\018\000\060\000\
\\019\000\059\000\034\000\122\000\049\000\057\000\050\000\056\000\
\\051\000\055\000\052\000\054\000\000\000\
\\001\000\006\000\071\000\008\000\070\000\009\000\069\000\010\000\068\000\
\\011\000\067\000\012\000\066\000\013\000\065\000\014\000\064\000\
\\015\000\063\000\016\000\062\000\017\000\061\000\018\000\060\000\
\\019\000\059\000\039\000\094\000\049\000\057\000\050\000\056\000\
\\051\000\055\000\052\000\054\000\000\000\
\\001\000\007\000\048\000\020\000\047\000\032\000\046\000\033\000\045\000\
\\038\000\044\000\040\000\043\000\041\000\042\000\059\000\041\000\000\000\
\\001\000\021\000\039\000\000\000\
\\001\000\022\000\012\000\023\000\011\000\036\000\106\000\054\000\010\000\
\\056\000\009\000\000\000\
\\001\000\024\000\031\000\025\000\030\000\029\000\029\000\037\000\119\000\
\\040\000\028\000\055\000\027\000\057\000\026\000\000\000\
\\001\000\027\000\117\000\028\000\117\000\031\000\117\000\034\000\117\000\
\\042\000\117\000\000\000\
\\001\000\027\000\097\000\000\000\
\\001\000\028\000\099\000\000\000\
\\001\000\031\000\096\000\000\000\
\\001\000\034\000\102\000\042\000\102\000\000\000\
\\001\000\034\000\107\000\036\000\107\000\000\000\
\\001\000\034\000\108\000\036\000\108\000\000\000\
\\001\000\034\000\109\000\036\000\109\000\056\000\009\000\000\000\
\\001\000\034\000\110\000\000\000\
\\001\000\034\000\112\000\035\000\023\000\000\000\
\\001\000\034\000\113\000\000\000\
\\001\000\034\000\120\000\000\000\
\\001\000\034\000\121\000\000\000\
\\001\000\034\000\123\000\000\000\
\\001\000\034\000\124\000\000\000\
\\001\000\034\000\125\000\000\000\
\\001\000\034\000\014\000\000\000\
\\001\000\034\000\022\000\000\000\
\\001\000\034\000\033\000\000\000\
\\001\000\034\000\035\000\000\000\
\\001\000\036\000\103\000\000\000\
\\001\000\036\000\104\000\056\000\009\000\000\000\
\\001\000\036\000\105\000\000\000\
\\001\000\036\000\111\000\056\000\111\000\000\000\
\\001\000\036\000\018\000\000\000\
\\001\000\037\000\118\000\000\000\
\\001\000\037\000\036\000\000\000\
\\001\000\040\000\114\000\000\000\
\\001\000\040\000\115\000\000\000\
\\001\000\040\000\116\000\000\000\
\\001\000\040\000\016\000\000\000\
\\001\000\040\000\019\000\000\000\
\\001\000\040\000\037\000\000\000\
\\001\000\040\000\038\000\000\000\
\\001\000\040\000\050\000\000\000\
\\001\000\042\000\000\000\000\000\
\\001\000\042\000\101\000\000\000\
\"
val actionRowNumbers =
"\031\000\054\000\049\000\055\000\
\\063\000\057\000\069\000\064\000\
\\062\000\061\000\060\000\053\000\
\\040\000\050\000\042\000\037\000\
\\032\000\031\000\038\000\051\000\
\\056\000\063\000\052\000\059\000\
\\065\000\066\000\030\000\029\000\
\\029\000\067\000\041\000\040\000\
\\043\000\032\000\033\000\045\000\
\\046\000\029\000\026\000\013\000\
\\007\000\000\000\029\000\016\000\
\\015\000\029\000\029\000\025\000\
\\044\000\039\000\058\000\027\000\
\\029\000\029\000\029\000\029\000\
\\057\000\029\000\029\000\029\000\
\\029\000\029\000\029\000\029\000\
\\029\000\029\000\029\000\029\000\
\\029\000\029\000\028\000\014\000\
\\012\000\057\000\011\000\010\000\
\\009\000\008\000\036\000\024\000\
\\023\000\017\000\018\000\019\000\
\\020\000\022\000\021\000\006\000\
\\005\000\004\000\003\000\002\000\
\\001\000\034\000\048\000\057\000\
\\035\000\047\000\068\000"
val gotoT =
"\
\\001\000\098\000\002\000\006\000\003\000\005\000\007\000\004\000\
\\010\000\003\000\011\000\002\000\013\000\001\000\000\000\
\\010\000\011\000\011\000\002\000\000\000\
\\000\000\
\\000\000\
\\008\000\013\000\000\000\
\\004\000\015\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\010\000\019\000\011\000\002\000\012\000\018\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\005\000\023\000\006\000\022\000\000\000\
\\002\000\030\000\003\000\005\000\007\000\004\000\010\000\003\000\
\\011\000\002\000\013\000\001\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\008\000\032\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\009\000\038\000\000\000\
\\009\000\047\000\000\000\
\\000\000\
\\000\000\
\\010\000\019\000\011\000\002\000\012\000\049\000\000\000\
\\000\000\
\\005\000\050\000\006\000\022\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\009\000\051\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\009\000\070\000\000\000\
\\000\000\
\\000\000\
\\009\000\071\000\000\000\
\\009\000\072\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\009\000\074\000\000\000\
\\009\000\075\000\000\000\
\\009\000\076\000\000\000\
\\009\000\077\000\000\000\
\\004\000\078\000\000\000\
\\009\000\079\000\000\000\
\\009\000\080\000\000\000\
\\009\000\081\000\000\000\
\\009\000\082\000\000\000\
\\009\000\083\000\000\000\
\\009\000\084\000\000\000\
\\009\000\085\000\000\000\
\\009\000\086\000\000\000\
\\009\000\087\000\000\000\
\\009\000\088\000\000\000\
\\009\000\089\000\000\000\
\\009\000\090\000\000\000\
\\009\000\091\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\004\000\093\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\004\000\096\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\"
val numstates = 99
val numrules = 50
val s = ref "" and index = ref 0
val string_to_int = fn () => 
let val i = !index
in index := i+2; Char.ord(String.sub(!s,i)) + Char.ord(String.sub(!s,i+1)) * 256
end
val string_to_list = fn s' =>
    let val len = String.size s'
        fun f () =
           if !index < len then string_to_int() :: f()
           else nil
   in index := 0; s := s'; f ()
   end
val string_to_pairlist = fn (conv_key,conv_entry) =>
     let fun f () =
         case string_to_int()
         of 0 => EMPTY
          | n => PAIR(conv_key (n-1),conv_entry (string_to_int()),f())
     in f
     end
val string_to_pairlist_default = fn (conv_key,conv_entry) =>
    let val conv_row = string_to_pairlist(conv_key,conv_entry)
    in fn () =>
       let val default = conv_entry(string_to_int())
           val row = conv_row()
       in (row,default)
       end
   end
val string_to_table = fn (convert_row,s') =>
    let val len = String.size s'
        fun f ()=
           if !index < len then convert_row() :: f()
           else nil
     in (s := s'; index := 0; f ())
     end
local
  val memo = Array.array(numstates+numrules,ERROR)
  val _ =let fun g i=(Array.update(memo,i,REDUCE(i-numstates)); g(i+1))
       fun f i =
            if i=numstates then g i
            else (Array.update(memo,i,SHIFT (STATE i)); f (i+1))
          in f 0 handle General.Subscript => ()
          end
in
val entry_to_action = fn 0 => ACCEPT | 1 => ERROR | j => Array.sub(memo,(j-2))
end
val gotoT=Array.fromList(string_to_table(string_to_pairlist(NT,STATE),gotoT))
val actionRows=string_to_table(string_to_pairlist_default(T,entry_to_action),actionRows)
val actionRowNumbers = string_to_list actionRowNumbers
val actionT = let val actionRowLookUp=
let val a=Array.fromList(actionRows) in fn i=>Array.sub(a,i) end
in Array.fromList(List.map actionRowLookUp actionRowNumbers)
end
in LrTable.mkLrTable {actions=actionT,gotos=gotoT,numRules=numrules,
numStates=numstates,initialState=STATE 0}
end
end
local open Header in
type pos = int
type arg = string
structure MlyValue = 
struct
datatype svalue = VOID | ntVOID of unit ->  unit
 | Token_R of unit ->  (string*string)
 | Token_Num of unit ->  (string) | Token_Ident of unit ->  (string)
 | vardec of unit ->  (DataTypes.VarDecls)
 | procdeclist of unit ->  (DataTypes.ProcDecls list)
 | procdef of unit ->  (DataTypes.ProcDef)
 | procdec of unit ->  (DataTypes.ProcDecls)
 | expr of unit ->  (DataTypes.Type*DataTypes.Expression)
 | varlist of unit ->  (string list)
 | typedec of unit ->  (DataTypes.Type)
 | Command of unit ->  (DataTypes.Command_D)
 | Commands of unit ->  (DataTypes.Command_D list)
 | cmdseq of unit ->  (DataTypes.Command_D list)
 | decseq of unit ->  (DataTypes.DeclarationSeq)
 | blk of unit ->  (DataTypes.Block)
 | start of unit ->  (DataTypes.Start)
end
type svalue = MlyValue.svalue
type result = DataTypes.Start
end
structure EC=
struct
open LrTable
infix 5 $$
fun x $$ y = y::x
val is_keyword =
fn _ => false
val preferred_change : (term list * term list) list = 
nil
val noShift = 
fn (T 41) => true | _ => false
val showTerminal =
fn (T 0) => "Token_Lt"
  | (T 1) => "Token_From_decimal"
  | (T 2) => "Token_Id"
  | (T 3) => "Token_Rational"
  | (T 4) => "Token_Var"
  | (T 5) => "Token_Plus"
  | (T 6) => "Token_Uni_minus"
  | (T 7) => "Token_Minus"
  | (T 8) => "Token_Multiply"
  | (T 9) => "Token_Divide"
  | (T 10) => "Token_Modulus"
  | (T 11) => "Token_Equal"
  | (T 12) => "Token_Ne"
  | (T 13) => "Token_Gt"
  | (T 14) => "Token_Gte"
  | (T 15) => "Token_LT"
  | (T 16) => "Token_Lte"
  | (T 17) => "Token_And"
  | (T 18) => "Token_Or"
  | (T 19) => "Token_Negation"
  | (T 20) => "Token_Assign"
  | (T 21) => "Token_Int"
  | (T 22) => "Token_Bool"
  | (T 23) => "Token_Read"
  | (T 24) => "Token_If"
  | (T 25) => "Token_then"
  | (T 26) => "Token_else"
  | (T 27) => "Token_fi"
  | (T 28) => "Token_while"
  | (T 29) => "Token_do"
  | (T 30) => "Token_od"
  | (T 31) => "Token_tt"
  | (T 32) => "Token_ff"
  | (T 33) => "Token_Semicolon"
  | (T 34) => "Token_Comma"
  | (T 35) => "Token_Lbrace"
  | (T 36) => "Token_Rbrace"
  | (T 37) => "Token_Lparen"
  | (T 38) => "Token_Rparen"
  | (T 39) => "Token_Ident"
  | (T 40) => "Token_Num"
  | (T 41) => "Token_EOF"
  | (T 42) => "Token_Show_rat"
  | (T 43) => "Token_Make_rat"
  | (T 44) => "Token_Left_comm"
  | (T 45) => "Token_Right_comm"
  | (T 46) => "Token_Show_decimal"
  | (T 47) => "Token_To_decimal"
  | (T 48) => "Token_Rplus"
  | (T 49) => "Token_Rminus"
  | (T 50) => "Token_Rmultiply"
  | (T 51) => "Token_Rdivide"
  | (T 52) => "Token_Inverse"
  | (T 53) => "Token_Rati"
  | (T 54) => "Token_Call"
  | (T 55) => "Token_Procedure"
  | (T 56) => "Token_Print"
  | (T 57) => "Token_Rat"
  | (T 58) => "Token_R"
  | _ => "bogus-term"
local open Header in
val errtermvalue=
fn _ => MlyValue.VOID
end
val terms : term list = nil
 $$ (T 57) $$ (T 56) $$ (T 55) $$ (T 54) $$ (T 53) $$ (T 52) $$ (T 51)
 $$ (T 50) $$ (T 49) $$ (T 48) $$ (T 47) $$ (T 46) $$ (T 45) $$ (T 44)
 $$ (T 43) $$ (T 42) $$ (T 41) $$ (T 38) $$ (T 37) $$ (T 36) $$ (T 35)
 $$ (T 34) $$ (T 33) $$ (T 32) $$ (T 31) $$ (T 30) $$ (T 29) $$ (T 28)
 $$ (T 27) $$ (T 26) $$ (T 25) $$ (T 24) $$ (T 23) $$ (T 22) $$ (T 21)
 $$ (T 20) $$ (T 19) $$ (T 18) $$ (T 17) $$ (T 16) $$ (T 15) $$ (T 14)
 $$ (T 13) $$ (T 12) $$ (T 11) $$ (T 10) $$ (T 9) $$ (T 8) $$ (T 7)
 $$ (T 6) $$ (T 5) $$ (T 4) $$ (T 3) $$ (T 2) $$ (T 1) $$ (T 0)end
structure Actions =
struct 
exception mlyAction of int
local open Header in
val actions = 
fn (i392,defaultPos,stack,
    (filename):arg) =>
case (i392,stack)
of  ( 0, ( ( _, ( MlyValue.blk blk1, blk1left, blk1right)) :: rest671)
) => let val  result = MlyValue.start (fn _ => let val  (blk as blk1)
 = blk1 ()
 in (HashTable.clear SymbolTable ; DataTypes.Program(blk))
end)
 in ( LrTable.NT 0, ( result, blk1left, blk1right), rest671)
end
|  ( 1, ( ( _, ( MlyValue.cmdseq cmdseq1, _, cmdseq1right)) :: ( _, ( 
MlyValue.decseq decseq1, decseq1left, _)) :: rest671)) => let val  
result = MlyValue.blk (fn _ => let val  (decseq as decseq1) = decseq1
 ()
 val  (cmdseq as cmdseq1) = cmdseq1 ()
 in (DataTypes.Block(decseq,cmdseq))
end)
 in ( LrTable.NT 1, ( result, decseq1left, cmdseq1right), rest671)
end
|  ( 2, ( ( _, ( MlyValue.procdec procdec1, _, procdec1right)) :: ( _,
 ( MlyValue.vardec vardec1, vardec1left, _)) :: rest671)) => let val  
result = MlyValue.decseq (fn _ => let val  (vardec as vardec1) = 
vardec1 ()
 val  (procdec as procdec1) = procdec1 ()
 in (DataTypes.DeclarationSeq(SOME vardec,SOME procdec))
end)
 in ( LrTable.NT 2, ( result, vardec1left, procdec1right), rest671)

end
|  ( 3, ( ( _, ( MlyValue.vardec vardec1, vardec1left, vardec1right))
 :: rest671)) => let val  result = MlyValue.decseq (fn _ => let val  (
vardec as vardec1) = vardec1 ()
 in (DataTypes.DeclarationSeq(SOME vardec,NONE))
end)
 in ( LrTable.NT 2, ( result, vardec1left, vardec1right), rest671)
end
|  ( 4, ( ( _, ( MlyValue.procdec procdec1, procdec1left, 
procdec1right)) :: rest671)) => let val  result = MlyValue.decseq (fn
 _ => let val  (procdec as procdec1) = procdec1 ()
 in (DataTypes.DeclarationSeq(NONE,SOME procdec))
end)
 in ( LrTable.NT 2, ( result, procdec1left, procdec1right), rest671)

end
|  ( 5, ( rest671)) => let val  result = MlyValue.decseq (fn _ => (
DataTypes.DeclarationSeq(NONE,NONE)))
 in ( LrTable.NT 2, ( result, defaultPos, defaultPos), rest671)
end
|  ( 6, ( ( _, ( MlyValue.procdeclist procdeclist1, _, 
procdeclist1right)) :: _ :: ( _, ( MlyValue.procdef procdef1, 
procdef1left, _)) :: rest671)) => let val  result = MlyValue.procdec
 (fn _ => let val  (procdef as procdef1) = procdef1 ()
 val  (procdeclist as procdeclist1) = procdeclist1 ()
 in (DataTypes.ProcDecls( procdef,procdeclist))
end)
 in ( LrTable.NT 9, ( result, procdef1left, procdeclist1right), 
rest671)
end
|  ( 7, ( ( _, ( MlyValue.procdeclist procdeclist1, _, 
procdeclist1right)) :: _ :: ( _, ( MlyValue.procdec procdec1, 
procdec1left, _)) :: rest671)) => let val  result = 
MlyValue.procdeclist (fn _ => let val  (procdec as procdec1) = 
procdec1 ()
 val  (procdeclist as procdeclist1) = procdeclist1 ()
 in (procdec :: procdeclist )
end)
 in ( LrTable.NT 11, ( result, procdec1left, procdeclist1right), 
rest671)
end
|  ( 8, ( rest671)) => let val  result = MlyValue.procdeclist (fn _ =>
 (([])))
 in ( LrTable.NT 11, ( result, defaultPos, defaultPos), rest671)
end
|  ( 9, ( ( _, ( MlyValue.blk blk1, _, blk1right)) :: ( _, ( 
MlyValue.Token_Ident Token_Ident1, _, _)) :: ( _, ( _, 
Token_Procedure1left, _)) :: rest671)) => let val  result = 
MlyValue.procdef (fn _ => let val  (Token_Ident as Token_Ident1) = 
Token_Ident1 ()
 val  (blk as blk1) = blk1 ()
 in (DataTypes.ProcDef(Token_Ident, blk))
end)
 in ( LrTable.NT 10, ( result, Token_Procedure1left, blk1right), 
rest671)
end
|  ( 10, ( ( _, ( _, _, Token_Semicolon1right)) :: ( _, ( 
MlyValue.varlist varlist1, _, _)) :: ( _, ( MlyValue.typedec typedec1,
 typedec1left, _)) :: rest671)) => let val  result = MlyValue.vardec
 (fn _ => let val  (typedec as typedec1) = typedec1 ()
 val  (varlist as varlist1) = varlist1 ()
 in (
( insert( varlist , typedec) ; DataTypes.VarDecls(varlist ,typedec)))

end)
 in ( LrTable.NT 12, ( result, typedec1left, Token_Semicolon1right), 
rest671)
end
|  ( 11, ( ( _, ( MlyValue.Token_Ident Token_Ident1, Token_Ident1left,
 Token_Ident1right)) :: rest671)) => let val  result = 
MlyValue.varlist (fn _ => let val  (Token_Ident as Token_Ident1) = 
Token_Ident1 ()
 in (([Token_Ident]))
end)
 in ( LrTable.NT 7, ( result, Token_Ident1left, Token_Ident1right), 
rest671)
end
|  ( 12, ( ( _, ( MlyValue.varlist varlist1, _, varlist1right)) :: _
 :: ( _, ( MlyValue.Token_Ident Token_Ident1, Token_Ident1left, _)) ::
 rest671)) => let val  result = MlyValue.varlist (fn _ => let val  (
Token_Ident as Token_Ident1) = Token_Ident1 ()
 val  (varlist as varlist1) = varlist1 ()
 in ((Token_Ident::varlist))
end)
 in ( LrTable.NT 7, ( result, Token_Ident1left, varlist1right), 
rest671)
end
|  ( 13, ( ( _, ( _, Token_Int1left, Token_Int1right)) :: rest671)) =>
 let val  result = MlyValue.typedec (fn _ => ((Int)))
 in ( LrTable.NT 6, ( result, Token_Int1left, Token_Int1right), 
rest671)
end
|  ( 14, ( ( _, ( _, Token_Bool1left, Token_Bool1right)) :: rest671))
 => let val  result = MlyValue.typedec (fn _ => ((Bool)))
 in ( LrTable.NT 6, ( result, Token_Bool1left, Token_Bool1right), 
rest671)
end
|  ( 15, ( ( _, ( _, Token_Rati1left, Token_Rati1right)) :: rest671))
 => let val  result = MlyValue.typedec (fn _ => ((rational)))
 in ( LrTable.NT 6, ( result, Token_Rati1left, Token_Rati1right), 
rest671)
end
|  ( 16, ( ( _, ( _, _, Token_Rbrace1right)) :: ( _, ( 
MlyValue.Commands Commands1, _, _)) :: ( _, ( _, Token_Lbrace1left, _)
) :: rest671)) => let val  result = MlyValue.cmdseq (fn _ => let val 
 (Commands as Commands1) = Commands1 ()
 in ((Commands))
end)
 in ( LrTable.NT 3, ( result, Token_Lbrace1left, Token_Rbrace1right), 
rest671)
end
|  ( 17, ( ( _, ( MlyValue.Commands Commands1, _, Commands1right)) ::
 _ :: ( _, ( MlyValue.Command Command1, Command1left, _)) :: rest671))
 => let val  result = MlyValue.Commands (fn _ => let val  (Command as 
Command1) = Command1 ()
 val  (Commands as Commands1) = Commands1 ()
 in ((Command::Commands))
end)
 in ( LrTable.NT 4, ( result, Command1left, Commands1right), rest671)

end
|  ( 18, ( rest671)) => let val  result = MlyValue.Commands (fn _ => (
([])))
 in ( LrTable.NT 4, ( result, defaultPos, defaultPos), rest671)
end
|  ( 19, ( ( _, ( MlyValue.Token_Ident Token_Ident1, _, 
Token_Ident1right)) :: ( _, ( _, Token_Read1left, _)) :: rest671)) =>
 let val  result = MlyValue.Command (fn _ => let val  (Token_Ident as 
Token_Ident1) = Token_Ident1 ()
 in ((DataTypes.Read(Token_Ident)))
end)
 in ( LrTable.NT 5, ( result, Token_Read1left, Token_Ident1right), 
rest671)
end
|  ( 20, ( ( _, ( MlyValue.Token_Ident Token_Ident1, _, 
Token_Ident1right)) :: ( _, ( _, Token_Print1left, _)) :: rest671)) =>
 let val  result = MlyValue.Command (fn _ => let val  (Token_Ident as 
Token_Ident1) = Token_Ident1 ()
 in ((DataTypes.Print(Token_Ident)))
end)
 in ( LrTable.NT 5, ( result, Token_Print1left, Token_Ident1right), 
rest671)
end
|  ( 21, ( ( _, ( MlyValue.expr expr1, _, expr1right)) :: _ :: ( _, ( 
MlyValue.Token_Ident Token_Ident1, Token_Ident1left, _)) :: rest671))
 => let val  result = MlyValue.Command (fn _ => let val  (Token_Ident
 as Token_Ident1) = Token_Ident1 ()
 val  (expr as expr1) = expr1 ()
 in (
( if (checkSameType( gettype Token_Ident, #1 expr)) then () else raise TypeErrOr; DataTypes.AssignmentCmd(Token_Ident,  #2 expr ))
)
end)
 in ( LrTable.NT 5, ( result, Token_Ident1left, expr1right), rest671)

end
|  ( 22, ( ( _, ( MlyValue.Token_Ident Token_Ident1, _, 
Token_Ident1right)) :: ( _, ( _, Token_Call1left, _)) :: rest671)) =>
 let val  result = MlyValue.Command (fn _ => let val  (Token_Ident as 
Token_Ident1) = Token_Ident1 ()
 in ((DataTypes.Call(Token_Ident)))
end)
 in ( LrTable.NT 5, ( result, Token_Call1left, Token_Ident1right), 
rest671)
end
|  ( 23, ( ( _, ( _, _, Token_fi1right)) :: ( _, ( MlyValue.cmdseq 
cmdseq2, _, _)) :: _ :: ( _, ( MlyValue.cmdseq cmdseq1, _, _)) :: _ ::
 ( _, ( MlyValue.expr expr1, _, _)) :: ( _, ( _, Token_If1left, _)) ::
 rest671)) => let val  result = MlyValue.Command (fn _ => let val  (
expr as expr1) = expr1 ()
 val  (cmdseq as cmdseq1) = cmdseq1 ()
 val  cmdseq2 = cmdseq2 ()
 in (
( if (Bool_check (#1 expr)) then () else raise TypeErrOr ; DataTypes.IfThenElse( #2 expr, cmdseq, cmdseq))
)
end)
 in ( LrTable.NT 5, ( result, Token_If1left, Token_fi1right), rest671)

end
|  ( 24, ( ( _, ( _, _, Token_od1right)) :: ( _, ( MlyValue.cmdseq 
cmdseq1, _, _)) :: _ :: ( _, ( MlyValue.expr expr1, _, _)) :: ( _, ( _
, Token_while1left, _)) :: rest671)) => let val  result = 
MlyValue.Command (fn _ => let val  (expr as expr1) = expr1 ()
 val  (cmdseq as cmdseq1) = cmdseq1 ()
 in (
( if (Bool_check (#1 expr)) then () else raise TypeErrOr ; DataTypes.While( #2 expr, cmdseq ))
)
end)
 in ( LrTable.NT 5, ( result, Token_while1left, Token_od1right), 
rest671)
end
|  ( 25, ( ( _, ( MlyValue.Token_Ident Token_Ident1, Token_Ident1left,
 Token_Ident1right)) :: rest671)) => let val  result = MlyValue.expr
 (fn _ => let val  (Token_Ident as Token_Ident1) = Token_Ident1 ()
 in (( gettype Token_Ident , DataTypes.Ident(Token_Ident)))
end)
 in ( LrTable.NT 8, ( result, Token_Ident1left, Token_Ident1right), 
rest671)
end
|  ( 26, ( ( _, ( _, _, Token_Rparen1right)) :: ( _, ( MlyValue.expr 
expr1, _, _)) :: ( _, ( _, Token_Lparen1left, _)) :: rest671)) => let
 val  result = MlyValue.expr (fn _ => let val  (expr as expr1) = expr1
 ()
 in ((expr))
end)
 in ( LrTable.NT 8, ( result, Token_Lparen1left, Token_Rparen1right), 
rest671)
end
|  ( 27, ( ( _, ( MlyValue.expr expr2, _, expr2right)) :: _ :: ( _, ( 
MlyValue.expr expr1, expr1left, _)) :: rest671)) => let val  result = 
MlyValue.expr (fn _ => let val  expr1 = expr1 ()
 val  expr2 = expr2 ()
 in (
( if int_check( #1  expr1) andalso int_check( #1 expr2) then () else raise TypeErrOr ;(Int , DataTypes.Plus(#2 expr1 , #2 expr2)))
)
end)
 in ( LrTable.NT 8, ( result, expr1left, expr2right), rest671)
end
|  ( 28, ( ( _, ( MlyValue.expr expr2, _, expr2right)) :: _ :: ( _, ( 
MlyValue.expr expr1, expr1left, _)) :: rest671)) => let val  result = 
MlyValue.expr (fn _ => let val  expr1 = expr1 ()
 val  expr2 = expr2 ()
 in (
( if int_check( #1  expr1) andalso int_check( #1 expr2) then () else raise TypeErrOr ;(Int , DataTypes.Minus(#2 expr1 , #2 expr2)))
)
end)
 in ( LrTable.NT 8, ( result, expr1left, expr2right), rest671)
end
|  ( 29, ( ( _, ( MlyValue.expr expr2, _, expr2right)) :: _ :: ( _, ( 
MlyValue.expr expr1, expr1left, _)) :: rest671)) => let val  result = 
MlyValue.expr (fn _ => let val  expr1 = expr1 ()
 val  expr2 = expr2 ()
 in (
(if int_check( #1  expr1) andalso int_check( #1 expr2) then () else raise TypeErrOr ; (Int , DataTypes.Multiply(#2 expr1 , #2 expr2)))
)
end)
 in ( LrTable.NT 8, ( result, expr1left, expr2right), rest671)
end
|  ( 30, ( ( _, ( MlyValue.expr expr2, _, expr2right)) :: _ :: ( _, ( 
MlyValue.expr expr1, expr1left, _)) :: rest671)) => let val  result = 
MlyValue.expr (fn _ => let val  expr1 = expr1 ()
 val  expr2 = expr2 ()
 in (
( if int_check( #1  expr1) andalso int_check( #1 expr2) then () else raise TypeErrOr ;(Int , DataTypes.Divide(#2 expr1 , #2 expr2)))
)
end)
 in ( LrTable.NT 8, ( result, expr1left, expr2right), rest671)
end
|  ( 31, ( ( _, ( MlyValue.expr expr2, _, expr2right)) :: _ :: ( _, ( 
MlyValue.expr expr1, expr1left, _)) :: rest671)) => let val  result = 
MlyValue.expr (fn _ => let val  expr1 = expr1 ()
 val  expr2 = expr2 ()
 in (
( if int_check( #1  expr1) andalso int_check( #1 expr2) then () else raise TypeErrOr ;(Int , DataTypes.Modulus(#2 expr1 , #2 expr2)))
)
end)
 in ( LrTable.NT 8, ( result, expr1left, expr2right), rest671)
end
|  ( 32, ( ( _, ( MlyValue.Token_Num Token_Num1, Token_Num1left, 
Token_Num1right)) :: rest671)) => let val  result = MlyValue.expr (fn
 _ => let val  (Token_Num as Token_Num1) = Token_Num1 ()
 in (( Int , DataTypes.Num(Token_Num) ))
end)
 in ( LrTable.NT 8, ( result, Token_Num1left, Token_Num1right), 
rest671)
end
|  ( 33, ( ( _, ( MlyValue.expr expr2, _, expr2right)) :: _ :: ( _, ( 
MlyValue.expr expr1, expr1left, _)) :: rest671)) => let val  result = 
MlyValue.expr (fn _ => let val  expr1 = expr1 ()
 val  expr2 = expr2 ()
 in (
( if Rati_check( #1  expr1) andalso Rati_check( #1 expr2) then () else raise TypeErrOr ;(rational , DataTypes.Rplus(#2 expr1 , #2 expr2)))
)
end)
 in ( LrTable.NT 8, ( result, expr1left, expr2right), rest671)
end
|  ( 34, ( ( _, ( MlyValue.expr expr2, _, expr2right)) :: _ :: ( _, ( 
MlyValue.expr expr1, expr1left, _)) :: rest671)) => let val  result = 
MlyValue.expr (fn _ => let val  expr1 = expr1 ()
 val  expr2 = expr2 ()
 in (
( if Rati_check( #1  expr1) andalso Rati_check( #1 expr2) then () else raise TypeErrOr ;(rational , DataTypes.Rminus(#2 expr1 , #2 expr2)))
)
end)
 in ( LrTable.NT 8, ( result, expr1left, expr2right), rest671)
end
|  ( 35, ( ( _, ( MlyValue.expr expr2, _, expr2right)) :: _ :: ( _, ( 
MlyValue.expr expr1, expr1left, _)) :: rest671)) => let val  result = 
MlyValue.expr (fn _ => let val  expr1 = expr1 ()
 val  expr2 = expr2 ()
 in (
(if Rati_check( #1  expr1) andalso Rati_check( #1 expr2) then () else raise TypeErrOr ; (rational , DataTypes.Rmultiply(#2 expr1 , #2 expr2)))
)
end)
 in ( LrTable.NT 8, ( result, expr1left, expr2right), rest671)
end
|  ( 36, ( ( _, ( MlyValue.expr expr2, _, expr2right)) :: _ :: ( _, ( 
MlyValue.expr expr1, expr1left, _)) :: rest671)) => let val  result = 
MlyValue.expr (fn _ => let val  expr1 = expr1 ()
 val  expr2 = expr2 ()
 in (
( if Rati_check( #1  expr1) andalso Rati_check( #1 expr2) then () else raise TypeErrOr ;(rational , DataTypes.Rdivide(#2 expr1 , #2 expr2)))
)
end)
 in ( LrTable.NT 8, ( result, expr1left, expr2right), rest671)
end
|  ( 37, ( ( _, ( MlyValue.expr expr1, _, expr1right)) :: ( _, ( _, 
Token_Uni_minus1left, _)) :: rest671)) => let val  result = 
MlyValue.expr (fn _ => let val  (expr as expr1) = expr1 ()
 in (
(if Rati_check(#1 expr) then () else raise TypeErrOr ;(rational , DataTypes.RUni_minus( #2 expr)))
)
end)
 in ( LrTable.NT 8, ( result, Token_Uni_minus1left, expr1right), 
rest671)
end
|  ( 38, ( ( _, ( MlyValue.Token_R Token_R1, Token_R1left, 
Token_R1right)) :: rest671)) => let val  result = MlyValue.expr (fn _
 => let val  (Token_R as Token_R1) = Token_R1 ()
 in (( rational, DataTypes.R(Token_R) ))
end)
 in ( LrTable.NT 8, ( result, Token_R1left, Token_R1right), rest671)

end
|  ( 39, ( ( _, ( MlyValue.expr expr2, _, expr2right)) :: _ :: ( _, ( 
MlyValue.expr expr1, expr1left, _)) :: rest671)) => let val  result = 
MlyValue.expr (fn _ => let val  expr1 = expr1 ()
 val  expr2 = expr2 ()
 in (
( if checkSameType( #1 expr1, #1 expr2) then () else raise TypeErrOr ; (Bool, DataTypes.Lte( #2 expr1, #2 expr2)))
)
end)
 in ( LrTable.NT 8, ( result, expr1left, expr2right), rest671)
end
|  ( 40, ( ( _, ( MlyValue.expr expr2, _, expr2right)) :: _ :: ( _, ( 
MlyValue.expr expr1, expr1left, _)) :: rest671)) => let val  result = 
MlyValue.expr (fn _ => let val  expr1 = expr1 ()
 val  expr2 = expr2 ()
 in (
( if checkSameType( #1 expr1, #1 expr2) then () else raise TypeErrOr ; (Bool, DataTypes.Lt( #2 expr1, #2 expr2)))
)
end)
 in ( LrTable.NT 8, ( result, expr1left, expr2right), rest671)
end
|  ( 41, ( ( _, ( MlyValue.expr expr2, _, expr2right)) :: _ :: ( _, ( 
MlyValue.expr expr1, expr1left, _)) :: rest671)) => let val  result = 
MlyValue.expr (fn _ => let val  expr1 = expr1 ()
 val  expr2 = expr2 ()
 in (
( if checkSameType( #1 expr1, #1 expr2) then () else raise TypeErrOr ; (Bool, DataTypes.Gte( #2 expr1, #2 expr2)))
)
end)
 in ( LrTable.NT 8, ( result, expr1left, expr2right), rest671)
end
|  ( 42, ( ( _, ( MlyValue.expr expr2, _, expr2right)) :: _ :: ( _, ( 
MlyValue.expr expr1, expr1left, _)) :: rest671)) => let val  result = 
MlyValue.expr (fn _ => let val  expr1 = expr1 ()
 val  expr2 = expr2 ()
 in (
( if checkSameType( #1 expr1, #1 expr2) then () else raise TypeErrOr ; (Bool, DataTypes.Gt( #2 expr1, #2 expr2)))
)
end)
 in ( LrTable.NT 8, ( result, expr1left, expr2right), rest671)
end
|  ( 43, ( ( _, ( MlyValue.expr expr2, _, expr2right)) :: _ :: ( _, ( 
MlyValue.expr expr1, expr1left, _)) :: rest671)) => let val  result = 
MlyValue.expr (fn _ => let val  expr1 = expr1 ()
 val  expr2 = expr2 ()
 in (
( if checkSameType( #1 expr1, #1 expr2) then () else raise TypeErrOr ; (Bool, DataTypes.Equal( #2 expr1, #2 expr2)))
)
end)
 in ( LrTable.NT 8, ( result, expr1left, expr2right), rest671)
end
|  ( 44, ( ( _, ( MlyValue.expr expr2, _, expr2right)) :: _ :: ( _, ( 
MlyValue.expr expr1, expr1left, _)) :: rest671)) => let val  result = 
MlyValue.expr (fn _ => let val  expr1 = expr1 ()
 val  expr2 = expr2 ()
 in (
( if checkSameType( #1 expr1, #1 expr2) then () else raise TypeErrOr ; (Bool, DataTypes.Ne( #2 expr1, #2 expr2)))
)
end)
 in ( LrTable.NT 8, ( result, expr1left, expr2right), rest671)
end
|  ( 45, ( ( _, ( MlyValue.expr expr2, _, expr2right)) :: _ :: ( _, ( 
MlyValue.expr expr1, expr1left, _)) :: rest671)) => let val  result = 
MlyValue.expr (fn _ => let val  expr1 = expr1 ()
 val  expr2 = expr2 ()
 in (
(if Bool_check( #1  expr1) andalso Bool_check( #1 expr2) then () else raise TypeErrOr ;(Bool , DataTypes.And(#2 expr1 , #2 expr2)))
)
end)
 in ( LrTable.NT 8, ( result, expr1left, expr2right), rest671)
end
|  ( 46, ( ( _, ( MlyValue.expr expr2, _, expr2right)) :: _ :: ( _, ( 
MlyValue.expr expr1, expr1left, _)) :: rest671)) => let val  result = 
MlyValue.expr (fn _ => let val  expr1 = expr1 ()
 val  expr2 = expr2 ()
 in (
(if Bool_check( #1  expr1) andalso Bool_check( #1 expr2) then () else raise TypeErrOr ;(Bool , DataTypes.Or(#2 expr1 , #2 expr2)))
)
end)
 in ( LrTable.NT 8, ( result, expr1left, expr2right), rest671)
end
|  ( 47, ( ( _, ( MlyValue.expr expr1, _, expr1right)) :: ( _, ( _, 
Token_Negation1left, _)) :: rest671)) => let val  result = 
MlyValue.expr (fn _ => let val  (expr as expr1) = expr1 ()
 in (
(if Bool_check( #1  expr) then () else raise TypeErrOr ;(Bool , DataTypes.Negation(#2 expr)))
)
end)
 in ( LrTable.NT 8, ( result, Token_Negation1left, expr1right), 
rest671)
end
|  ( 48, ( ( _, ( _, Token_tt1left, Token_tt1right)) :: rest671)) =>
 let val  result = MlyValue.expr (fn _ => ((Bool,tt)))
 in ( LrTable.NT 8, ( result, Token_tt1left, Token_tt1right), rest671)

end
|  ( 49, ( ( _, ( _, Token_ff1left, Token_ff1right)) :: rest671)) =>
 let val  result = MlyValue.expr (fn _ => ((Bool,ff)))
 in ( LrTable.NT 8, ( result, Token_ff1left, Token_ff1right), rest671)

end
| _ => raise (mlyAction i392)
end
val void = MlyValue.VOID
val extract = fn a => (fn MlyValue.start x => x
| _ => let exception ParseInternal
	in raise ParseInternal end) a ()
end
end
structure Tokens : Ration_TOKENS =
struct
type svalue = ParserData.svalue
type ('a,'b) token = ('a,'b) Token.token
fun Token_Lt (p1,p2) = Token.TOKEN (ParserData.LrTable.T 0,(
ParserData.MlyValue.VOID,p1,p2))
fun Token_From_decimal (p1,p2) = Token.TOKEN (ParserData.LrTable.T 1,(
ParserData.MlyValue.VOID,p1,p2))
fun Token_Id (p1,p2) = Token.TOKEN (ParserData.LrTable.T 2,(
ParserData.MlyValue.VOID,p1,p2))
fun Token_Rational (p1,p2) = Token.TOKEN (ParserData.LrTable.T 3,(
ParserData.MlyValue.VOID,p1,p2))
fun Token_Var (p1,p2) = Token.TOKEN (ParserData.LrTable.T 4,(
ParserData.MlyValue.VOID,p1,p2))
fun Token_Plus (p1,p2) = Token.TOKEN (ParserData.LrTable.T 5,(
ParserData.MlyValue.VOID,p1,p2))
fun Token_Uni_minus (p1,p2) = Token.TOKEN (ParserData.LrTable.T 6,(
ParserData.MlyValue.VOID,p1,p2))
fun Token_Minus (p1,p2) = Token.TOKEN (ParserData.LrTable.T 7,(
ParserData.MlyValue.VOID,p1,p2))
fun Token_Multiply (p1,p2) = Token.TOKEN (ParserData.LrTable.T 8,(
ParserData.MlyValue.VOID,p1,p2))
fun Token_Divide (p1,p2) = Token.TOKEN (ParserData.LrTable.T 9,(
ParserData.MlyValue.VOID,p1,p2))
fun Token_Modulus (p1,p2) = Token.TOKEN (ParserData.LrTable.T 10,(
ParserData.MlyValue.VOID,p1,p2))
fun Token_Equal (p1,p2) = Token.TOKEN (ParserData.LrTable.T 11,(
ParserData.MlyValue.VOID,p1,p2))
fun Token_Ne (p1,p2) = Token.TOKEN (ParserData.LrTable.T 12,(
ParserData.MlyValue.VOID,p1,p2))
fun Token_Gt (p1,p2) = Token.TOKEN (ParserData.LrTable.T 13,(
ParserData.MlyValue.VOID,p1,p2))
fun Token_Gte (p1,p2) = Token.TOKEN (ParserData.LrTable.T 14,(
ParserData.MlyValue.VOID,p1,p2))
fun Token_LT (p1,p2) = Token.TOKEN (ParserData.LrTable.T 15,(
ParserData.MlyValue.VOID,p1,p2))
fun Token_Lte (p1,p2) = Token.TOKEN (ParserData.LrTable.T 16,(
ParserData.MlyValue.VOID,p1,p2))
fun Token_And (p1,p2) = Token.TOKEN (ParserData.LrTable.T 17,(
ParserData.MlyValue.VOID,p1,p2))
fun Token_Or (p1,p2) = Token.TOKEN (ParserData.LrTable.T 18,(
ParserData.MlyValue.VOID,p1,p2))
fun Token_Negation (p1,p2) = Token.TOKEN (ParserData.LrTable.T 19,(
ParserData.MlyValue.VOID,p1,p2))
fun Token_Assign (p1,p2) = Token.TOKEN (ParserData.LrTable.T 20,(
ParserData.MlyValue.VOID,p1,p2))
fun Token_Int (p1,p2) = Token.TOKEN (ParserData.LrTable.T 21,(
ParserData.MlyValue.VOID,p1,p2))
fun Token_Bool (p1,p2) = Token.TOKEN (ParserData.LrTable.T 22,(
ParserData.MlyValue.VOID,p1,p2))
fun Token_Read (p1,p2) = Token.TOKEN (ParserData.LrTable.T 23,(
ParserData.MlyValue.VOID,p1,p2))
fun Token_If (p1,p2) = Token.TOKEN (ParserData.LrTable.T 24,(
ParserData.MlyValue.VOID,p1,p2))
fun Token_then (p1,p2) = Token.TOKEN (ParserData.LrTable.T 25,(
ParserData.MlyValue.VOID,p1,p2))
fun Token_else (p1,p2) = Token.TOKEN (ParserData.LrTable.T 26,(
ParserData.MlyValue.VOID,p1,p2))
fun Token_fi (p1,p2) = Token.TOKEN (ParserData.LrTable.T 27,(
ParserData.MlyValue.VOID,p1,p2))
fun Token_while (p1,p2) = Token.TOKEN (ParserData.LrTable.T 28,(
ParserData.MlyValue.VOID,p1,p2))
fun Token_do (p1,p2) = Token.TOKEN (ParserData.LrTable.T 29,(
ParserData.MlyValue.VOID,p1,p2))
fun Token_od (p1,p2) = Token.TOKEN (ParserData.LrTable.T 30,(
ParserData.MlyValue.VOID,p1,p2))
fun Token_tt (p1,p2) = Token.TOKEN (ParserData.LrTable.T 31,(
ParserData.MlyValue.VOID,p1,p2))
fun Token_ff (p1,p2) = Token.TOKEN (ParserData.LrTable.T 32,(
ParserData.MlyValue.VOID,p1,p2))
fun Token_Semicolon (p1,p2) = Token.TOKEN (ParserData.LrTable.T 33,(
ParserData.MlyValue.VOID,p1,p2))
fun Token_Comma (p1,p2) = Token.TOKEN (ParserData.LrTable.T 34,(
ParserData.MlyValue.VOID,p1,p2))
fun Token_Lbrace (p1,p2) = Token.TOKEN (ParserData.LrTable.T 35,(
ParserData.MlyValue.VOID,p1,p2))
fun Token_Rbrace (p1,p2) = Token.TOKEN (ParserData.LrTable.T 36,(
ParserData.MlyValue.VOID,p1,p2))
fun Token_Lparen (p1,p2) = Token.TOKEN (ParserData.LrTable.T 37,(
ParserData.MlyValue.VOID,p1,p2))
fun Token_Rparen (p1,p2) = Token.TOKEN (ParserData.LrTable.T 38,(
ParserData.MlyValue.VOID,p1,p2))
fun Token_Ident (i,p1,p2) = Token.TOKEN (ParserData.LrTable.T 39,(
ParserData.MlyValue.Token_Ident (fn () => i),p1,p2))
fun Token_Num (i,p1,p2) = Token.TOKEN (ParserData.LrTable.T 40,(
ParserData.MlyValue.Token_Num (fn () => i),p1,p2))
fun Token_EOF (p1,p2) = Token.TOKEN (ParserData.LrTable.T 41,(
ParserData.MlyValue.VOID,p1,p2))
fun Token_Show_rat (p1,p2) = Token.TOKEN (ParserData.LrTable.T 42,(
ParserData.MlyValue.VOID,p1,p2))
fun Token_Make_rat (p1,p2) = Token.TOKEN (ParserData.LrTable.T 43,(
ParserData.MlyValue.VOID,p1,p2))
fun Token_Left_comm (p1,p2) = Token.TOKEN (ParserData.LrTable.T 44,(
ParserData.MlyValue.VOID,p1,p2))
fun Token_Right_comm (p1,p2) = Token.TOKEN (ParserData.LrTable.T 45,(
ParserData.MlyValue.VOID,p1,p2))
fun Token_Show_decimal (p1,p2) = Token.TOKEN (ParserData.LrTable.T 46
,(ParserData.MlyValue.VOID,p1,p2))
fun Token_To_decimal (p1,p2) = Token.TOKEN (ParserData.LrTable.T 47,(
ParserData.MlyValue.VOID,p1,p2))
fun Token_Rplus (p1,p2) = Token.TOKEN (ParserData.LrTable.T 48,(
ParserData.MlyValue.VOID,p1,p2))
fun Token_Rminus (p1,p2) = Token.TOKEN (ParserData.LrTable.T 49,(
ParserData.MlyValue.VOID,p1,p2))
fun Token_Rmultiply (p1,p2) = Token.TOKEN (ParserData.LrTable.T 50,(
ParserData.MlyValue.VOID,p1,p2))
fun Token_Rdivide (p1,p2) = Token.TOKEN (ParserData.LrTable.T 51,(
ParserData.MlyValue.VOID,p1,p2))
fun Token_Inverse (p1,p2) = Token.TOKEN (ParserData.LrTable.T 52,(
ParserData.MlyValue.VOID,p1,p2))
fun Token_Rati (p1,p2) = Token.TOKEN (ParserData.LrTable.T 53,(
ParserData.MlyValue.VOID,p1,p2))
fun Token_Call (p1,p2) = Token.TOKEN (ParserData.LrTable.T 54,(
ParserData.MlyValue.VOID,p1,p2))
fun Token_Procedure (p1,p2) = Token.TOKEN (ParserData.LrTable.T 55,(
ParserData.MlyValue.VOID,p1,p2))
fun Token_Print (p1,p2) = Token.TOKEN (ParserData.LrTable.T 56,(
ParserData.MlyValue.VOID,p1,p2))
fun Token_Rat (p1,p2) = Token.TOKEN (ParserData.LrTable.T 57,(
ParserData.MlyValue.VOID,p1,p2))
fun Token_R (i,p1,p2) = Token.TOKEN (ParserData.LrTable.T 58,(
ParserData.MlyValue.Token_R (fn () => i),p1,p2))
end
end
