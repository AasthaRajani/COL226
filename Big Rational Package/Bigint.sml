signature BIGINT=
    sig
        type bigint = string
        exception bigint_error 
        val negate : bigint -> bigint
        val add_int : bigint * bigint -> bigint
        val sub : bigint * bigint -> bigint
        val multiply_int : bigint * bigint -> bigint
        val division : bigint * bigint -> bigint 
        val modulus : bigint * bigint -> bigint
        val sign : bigint -> Int.int
        val sameSign : bigint * bigint -> bool
        val greater : bigint * bigint -> bool
        val greater_e : bigint * bigint -> bool
        val less_int : bigint * bigint -> bool
        val less_e : bigint * bigint -> bool
        end
structure Bigint :BIGINT = struct
type bigint= string
exception bigint_error
fun remove_zeroes(s,i,p)=
    if p= 0
    then
    "0"
    else if String.substring(s,i,1) <> "0"
    then
    s
    else
    remove_zeroes(String.substring(s,i+1,p-1),i,p-1)
fun sign(x) = 
    if String.substring(x,0,1)="~" then ~1
    else if remove_zeroes(x,0,String.size(x)) = "0" then 0
    else 1
fun sameSign(x,y)=
    let val sign_1 = sign(x)
        val sign_2 = sign(y)
    in 
        if sign_1=sign_2 orelse sign_1 = 0 orelse sign_2 = 0 then true else false
    end
fun make_equal(arr2,i,p)=
    if i=p
    then
        arr2
    else
        let 
            val partial_arr="0"^arr2
        in
            make_equal(partial_arr,i-1,p)
        end
fun negate x = 
    if String.substring(x,0,1)= "~" then remove_zeroes(String.substring(x,1,String.size(x)-1),0,String.size(String.substring(x,1,String.size(x)-1)))
    else "~" ^ remove_zeroes(x,0,String.size(x))
fun complement(arr,index,ans)=
    if index= ~1
    then 
        ans
    else
        let
            val SOME partial_ans_h=Int.fromString(String.substring(arr,index,1));
            val partial_com=9-partial_ans_h
        in
            complement(arr,index-1,Int.toString(partial_com)^ans)
        end
fun compare_ge(num1,num2,i)=
    if i=String.size(num1)
    then
        true
    else
        let
            val SOME c1=Int.fromString(String.substring(num1,i,1));
            val SOME c2=Int.fromString(String.substring(num2,i,1))
        in
            if c1 > c2 
            then 
                true
            else if c1 < c2
            then 
                false
            
            else
                compare_ge(num1,num2,i+1)
        end
fun compare_gt(num1,num2,i)=
    if i=String.size(num1)
    then
        false
    else
        let
            val SOME c1=Int.fromString(String.substring(num1,i,1));
            val SOME c2=Int.fromString(String.substring(num2,i,1))
        in
            if c1 > c2 
            then 
                true
            else if c1 < c2
            then 
                false
            
            else
                compare_gt(num1,num2,i+1)
        end
fun compare_ge_final(num1,num2)=
    let 
        val s1=String.size(num1);
        val s2=String.size(num2)
    in
        if s1>=s2
        then
            compare_ge(num1,make_equal(num2,s1,s2),0)
        else
            compare_ge(make_equal(num1,s2,s1),num2,0)
    end
fun greater_e(num1,num2)=
    let val sign_1=sign(num1)
        val sign_2=sign(num2)
    in
        if (sign_1= 0 orelse sign_1= 1) andalso (sign_2 = 0 orelse sign_2=1) then
            compare_ge_final(num1,num2)
        else if sign_1= ~1 andalso sign_2 = ~1 then
            let val n1 = String.extract(num1,1,NONE)
                val n2 = String.extract(num2,1,NONE)
            in not(compare_ge_final(n1,n2)) end
        else if sign_1 = ~1 then false
        else true
    end
fun compare_gt_final(num1,num2)=
    let 
        val s1=String.size(num1);
        val s2=String.size(num2)
    in
        if s1>=s2
        then
            compare_gt(num1,make_equal(num2,s1,s2),0)
        else
            compare_gt(make_equal(num1,s2,s1),num2,0)
    end
fun greater(num1,num2)=
    let val sign_1=sign(num1)
        val sign_2=sign(num2)
    in
        if (sign_1= 0 orelse sign_1= 1) andalso (sign_2 = 0 orelse sign_2=1) then
            compare_gt_final(num1,num2)
        else if sign_1= ~1 andalso sign_2 = ~1 then
            not(compare_gt_final(String.extract(num1,1,NONE),String.extract(num2,1,NONE)))
        else if sign_1 = ~1 then false
        else true
    end
fun less_e(num1,num2)=
    if  greater_e(num1,num2)=false then true else false

fun less_int(num1,num2)=
    if  greater(num1,num2)=false andalso greater_e(num1,num2) = false then true else false

fun multi_adder(arr1,arr2,carr,index,sum)=
    if index= ~1
    then 
        remove_zeroes(sum,0,String.size(sum))
    else
        let 
            val SOME partial_sum_h1=Int.fromString(String.substring(arr1,index,1));
            val SOME partial_sum_h2=Int.fromString(String.substring(arr2,index,1));
            val partial_sum=partial_sum_h1+carr+partial_sum_h2;
            val new_carr=partial_sum div 10;
            val new_sum=Int.toString(partial_sum mod 10)
        in
            multi_adder(arr1,arr2,new_carr,index-1,new_sum^sum)
        end
fun add_help(num1,num2)=
    let
        val s1=String.size(remove_zeroes(num1,0,String.size(num1)))
        val s2=String.size(remove_zeroes(num2,0,String.size(num2)))
    in 
        if s1>=s2
        then 
            multi_adder(remove_zeroes(num1,0,String.size(num1)),make_equal(remove_zeroes(num2,0,String.size(num2)),s1,s2),0,s1-1,"")
        else
            multi_adder(make_equal(remove_zeroes(num1,0,String.size(num1)),s2,s1),remove_zeroes(num2,0,String.size(num2)),0,s2-1,"")
    end
fun sub_help(arr1,arr2)=
    let
        val k=String.size(arr2);
        val arr2f=make_equal(arr2,String.size(arr1),k);
        val com_h=complement(arr2f,String.size(arr2f)-1,"");
        val com=add_help(com_h,"1");
        val addin=add_help(arr1,com)
    in
        remove_zeroes(addin,0,String.size(addin))
    end
fun mul(arr,i,carr,index,pr)= 
    if index= ~1
    then
        remove_zeroes(pr,0,String.size(pr))
    else
    let 
        val SOME partial_pr_h=Int.fromString(String.substring(arr,index,1));
        val partial_pr=partial_pr_h*i+carr;
        val new_carr=partial_pr div 10;
        val new_pr=Int.toString(partial_pr mod 10)
    in
        if index=0
        then
            mul(arr,i,new_carr,index-1,Int.toString(partial_pr)^pr)
        else
            mul(arr,i,new_carr,index-1,new_pr^pr)
    end
fun mul_10(num1)=
    let 
        val num1_f = num1^"0"
    in
        remove_zeroes(num1_f,0,String.size(num1_f))
    end

fun add_int(num1,num2)=
    let val sign_1=sign(num1)
        val sign_2=sign(num2)
    in
        if (sign_1= 0 orelse sign_1= 1) andalso (sign_2 = 0 orelse sign_2=1) then
            add_help(num1,num2)
        else if sign_1= ~1 andalso sign_2 = ~1 then
            let val s1=add_int(String.extract(num1,1,NONE),String.extract(num2,1,NONE)) in "~" ^ remove_zeroes(s1,0,String.size(s1)) end
        else if sign_1 = ~1 then 
            let val n1 = String.extract(num1,1,NONE)
                val n2 = num2
                val g = greater(n1,n2)
            in 
                if g = true then let val d = sub_help(n1,n2) in "~"^remove_zeroes(d,0,String.size(d)) end
                else let val d = sub_help(n2,n1) in remove_zeroes(d,0,String.size(d)) end
            end
        else 
            let val n2 = String.extract(num2,1,NONE)
                val n1 = num1
                val g = greater(n2,n1)
            in 
                if g = true then let val d = sub_help(n2,n1) in "~"^remove_zeroes(d,0,String.size(d)) end
                else let val d = sub_help(n1,n2) in remove_zeroes(d,0,String.size(d)) end
            end      
    end 
fun sub(num1,num2)=
    let val sign_1=sign(num1)
        val sign_2=sign(num2)
    in
        if (sign_1= 0 orelse sign_1= 1) andalso (sign_2 = 0 orelse sign_2=1) then
            let val g1 = greater(num1,num2)
                val g2 = greater_e(num1,num2)
            in if (g1=true orelse (g1=false andalso g2=true)) then sub_help(num1,num2) 
                else let val d = sub_help(num2,num1) in "~"^remove_zeroes(d,0,String.size(d)) end
            end
        else if sign_1= ~1 andalso sign_2 = ~1 then
            let val n1 = String.extract(num1,1,NONE)
                val n2 = String.extract(num2,1,NONE)
                val g = greater(n1,n2)
            in if g=true then let val d = sub_help(n1,n2) in "~"^remove_zeroes(d,0,String.size(d)) end
                else sub_help(n2,n1) 
            end
        else if sign_1 = ~1 then 
            let val n1 = String.extract(num1,1,NONE)
                val n2 = num2
            in 
                "~"^add_help(n1,n2)
            end
        else 
            let val n2 = String.extract(num2,1,NONE)
                val n1 = num1
            in 
                add_help(n1,n2)
            end      
    end
fun mul_helper(num1,num2,i,sum)=
    if i= ~1 then remove_zeroes(sum,0,String.size(sum))
    else 
        let 
            val SOME p = Int.fromString (String.substring(num2,i,1))
            val partial_product=mul(num1,p,0,String.size(num1)-1,"") 
            val new_num1=mul_10(num1)
            val new_sum=add_int(sum,partial_product)

        in
            mul_helper(new_num1,num2,i-1,new_sum)
        end
fun multiply_int(num1,num2)=
    if sign(remove_zeroes(num1,0,String.size(num1)))=0 orelse sign(remove_zeroes(num2,0,String.size(num2)))=0 then "0"
    else
    let val g=sameSign(num1,num2) in 
    if g=true then
        if sign(num1)= ~1 andalso sign(num2)= ~1 then
            let val n1= String.extract(num1,1,NONE)
                val n2= String.extract(num2,1,NONE)
            in mul_helper(n1,n2,String.size(n2)-1,"0")
            end
        else
            mul_helper(num1,num2,String.size(num2)-1,"0")
    else if sign(num1)= ~1 
        then let val h1= String.extract(num1,1,NONE) 
                val h2=mul_helper(h1,num2,String.size(num2)-1,"0")
                in "~" ^ h2 
                end
    else let val h1=mul_helper(num1,String.extract(num2,1,NONE),String.size(num2)-2,"0") in "~" ^ h1 end
    end
fun find_int(num1,num2,i)=
    let val prod=multiply_int(num2,Int.toString(i)) in 
    if greater(prod,num1)=true then i-1
    else if greater_e(prod,num1) = true then i
    else find_int(num1,num2,i+1) end
fun div_helper(num1,num2,digits,quotient,difference,flag,i)=
if i= String.size(num1) then (remove_zeroes(quotient,0,String.size(quotient)),remove_zeroes(difference,0,String.size(difference)))
(* else if String.size(num1)<String.size(num2) then ("0",num1) *)
else if less_int(num1,num2)=true then ("0",remove_zeroes(num1,0,String.size(num1)))
else
    if flag = false then
        let val new_div = String.substring(num1,0,digits)
        in  if greater_e(new_div,num2) then
                let val q=find_int(new_div,num2,1)
                    val prod = multiply_int(num2,Int.toString(q))
                    val diff = sub(new_div,prod)                        
                    in div_helper(num1,num2,digits,quotient^Int.toString(q),diff,true,digits)
                end
            else let val q=find_int(new_div^String.substring(num1,digits,1),num2,1)
                    val prod = multiply_int(num2,Int.toString(q))
                    val diff = sub(new_div^String.substring(num1,digits,1),prod)                        
                    in div_helper(num1,num2,digits,quotient^Int.toString(q),diff,true,digits+1)
                end
        end
    else
        let val new_div = difference^String.substring(num1,i,1)
            val q=find_int(new_div,num2,1)
            val prod = multiply_int(num2,Int.toString(q))
            val divi = remove_zeroes(new_div,0,String.size(new_div))
            val diff = sub(divi,prod) 
        in div_helper(num1,num2,digits,quotient^Int.toString(q),diff,true,i+1)
        end
fun division(num1,num2)=
    let val sign_1 = sign(num1)
        val sign_2 = sign(num2)
    in
        if sign_2 = 0 then raise bigint_error
        else if sign_1=0 then "0"
        else if (sign_1= 1) andalso (sign_2=1) then
        let
            val quo = div_helper(num1,num2,String.size(num2),"","0",false,0)
        in #1(quo) end
        else if sign_1= ~1 andalso sign_2 = ~1 then
        let
            val quo = div_helper(String.extract(num1,1,NONE),String.extract(num2,1,NONE),String.size(num2)-1,"","0",false,0)
        in #1(quo) end
        else if sign_1 = ~1 then 
            let val n1 = String.extract(num1,1,NONE)
                val n2 = num2
                val quo = div_helper(n1,n2,String.size(n2),"","0",false,0)
            in 
                "~" ^ #1(quo) end
        else 
            let val n2 = String.extract(num2,1,NONE)
                val n1 = num1
                val quo = div_helper(n1,n2,String.size(n2),"","0",false,0)
            in 
                "~" ^ #1(quo) end
    end 
    handle bigint_error=>"Error"
fun modulus(num1,num2)=
    let val sign_1 = sign(num1)
        val sign_2 = sign(num2)
    in
        if sign_2 = 0 then raise bigint_error
        else if sign_1 = 0 then "0"
        else if (sign_1= 1) andalso (sign_2=1) then
        let
            val quo = div_helper(num1,num2,String.size(num2),"","0",false,0)
            val rem = remove_zeroes(#2(quo),0,String.size(#2(quo)))
            in rem end
        else if sign_1= ~1 andalso sign_2 = ~1 then
        let
            val quo = div_helper(String.extract(num1,1,NONE),String.extract(num2,1,NONE),String.size(num2)-1,"","0",false,0)
            val rem = remove_zeroes(#2(quo),0,String.size(#2(quo)))
        in "~" ^ rem end
        else if sign_1 = ~1 then 
        let val n1 = String.extract(num1,1,NONE)
            val n2 = num2
            val quo = div_helper(n1,n2,String.size(n2),"","0",false,0)
            val rem = remove_zeroes(#2(quo),0,String.size(#2(quo)))
            val ans = sub(n2,rem)
        in 
            ans end
        else  
        let val n2 = String.extract(num2,1,NONE)
            val n1 = num1
            val quo = div_helper(n1,n2,String.size(n2),"","0",false,0)
            val rem = remove_zeroes(#2(quo),0,String.size(#2(quo)))
            val ans = sub(n2,rem)
        in 
            "~" ^ ans end
    end
    handle bigint_error=>"Error"
end;
open Bigint
functor Myfunctor(X : BIGINT): 
sig
    type rational=bigint * bigint 
    exception rat_error
    val make_rat: bigint * bigint -> rational option
    val rat: bigint -> rational option
    val reci: bigint -> rational option 
    val neg: rational -> rational
    val inverse : rational -> rational option 
    val equal : rational * rational -> bool (* equality *)
    val less : rational * rational -> bool (* less than *)
    val add : rational * rational -> rational (* addition *)
    val subtract : rational * rational -> rational (* subtraction *)
    val multiply : rational * rational -> rational (* multiplication *)
    val divide : rational * rational -> rational option (* division *)
    val showRat : rational -> string
    val showDecimal : rational -> string
    val fromDecimal : string -> rational
    val toDecimal : rational -> string
end
    =struct
    type rational=bigint * bigint
    exception rat_error
    fun remove_zeroes(s,i,p)=
        if p= 0
        then
        "0"
        else if String.substring(s,i,1) <> "0"
        then
        s
        else
        remove_zeroes(String.substring(s,i+1,p-1),i,p-1)
    fun gcd(p1,q1)=
        if greater(q1,"0")=false andalso greater_e(q1,"0") then remove_zeroes(p1,0,String.size(p1)) else gcd(q1,modulus(p1,q1))
    fun make_rat(p,q)=
        let val sign1=sign(p)
            val sign2=sign(q)
        in  if sign2=0 then raise rat_error
            else if (sign1=0 orelse sign1=1) andalso sign2=1 then 
                let val p1 = remove_zeroes(p,0,String.size(p))
                    val p2 = remove_zeroes(q,0,String.size(q))
                    val v1=gcd(p1,p2) 
                    val v2=division(p1,v1)
                    val v3=division(p2,v1)
                in SOME (remove_zeroes(v2,0,String.size(v2)),remove_zeroes(v3,0,String.size(v3)))
                end
            else if  sign1= ~1 andalso sign2 = ~1 then
                let val p1=remove_zeroes(String.extract(p,1,NONE),0,String.size(p)-1)
                    val p2=remove_zeroes(String.extract(q,1,NONE),0,String.size(q)-1)
                    val v1=gcd(p1,p2) 
                    val v2=division(p1,v1)
                    val v3=division(p2,v1)
                in SOME (remove_zeroes(v2,0,String.size(v2)),remove_zeroes(v3,0,String.size(v3)))
                end
            else if sign1 = ~1 then 
                let val p1=remove_zeroes(String.extract(p,1,NONE),0,String.size(p)-1)
                    val p2=remove_zeroes(q,0,String.size(q))
                    val v1=gcd(p1,p2) 
                    val v2=division(p1,v1)
                    val v3=division(p2,v1)
                in SOME ("~" ^ remove_zeroes(v2,0,String.size(v2)),remove_zeroes(v3,0,String.size(v3)))
                end
            else
                let val p1=remove_zeroes(p,0,String.size(p))
                    val p2=remove_zeroes(String.extract(q,1,NONE),0,String.size(q)-1)
                    val v1=gcd(p1,p2) 
                    val v2=division(p1,v1)
                    val v3=division(p2,v1)
                in 
                    if remove_zeroes(v2,0,String.size(v2)) = "0" then SOME (remove_zeroes(v2,0,String.size(v2)),remove_zeroes(v3,0,String.size(v3)))
                    else SOME ("~" ^ remove_zeroes(v2,0,String.size(v2)),remove_zeroes(v3,0,String.size(v3)))
                end
        end
        handle rat_error=>NONE
        (* handle rat_error=>NONE *)
    fun make_rat_copy(p,q)=
        let val sign1=sign(p)
            val sign2=sign(q)
        in  if sign2=0 then ("","")
            else if (sign1=0 orelse sign1=1) andalso sign2=1 then 
                let val p1 = remove_zeroes(p,0,String.size(p))
                    val p2 = remove_zeroes(q,0,String.size(q))
                    val v1=gcd(p1,p2) 
                    val v2=division(p1,v1)
                    val v3=division(p2,v1)
                in (remove_zeroes(v2,0,String.size(v2)),remove_zeroes(v3,0,String.size(v3)))
                end
            else if  sign1= ~1 andalso sign2 = ~1 then
                let val p1=remove_zeroes(String.extract(p,1,NONE),0,String.size(p)-1)
                    val p2=remove_zeroes(String.extract(q,1,NONE),0,String.size(q)-1)
                    val v1=gcd(p1,p2) 
                    val v2=division(p1,v1)
                    val v3=division(p2,v1)
                in (remove_zeroes(v2,0,String.size(v2)),remove_zeroes(v3,0,String.size(v3)))
                end
            else if sign1 = ~1 then 
                let val p1=remove_zeroes(String.extract(p,1,NONE),0,String.size(p)-1)
                    val p2=remove_zeroes(q,0,String.size(q))
                    val v1=gcd(p1,p2) 
                    val v2=division(p1,v1)
                    val v3=division(p2,v1)
                in ("~" ^ remove_zeroes(v2,0,String.size(v2)),remove_zeroes(v3,0,String.size(v3)))
                end
            else
                let val p1=remove_zeroes(p,0,String.size(p))
                    val p2=remove_zeroes(String.extract(q,1,NONE),0,String.size(q)-1)
                    val v1=gcd(p1,p2) 
                    val v2=division(p1,v1)
                    val v3=division(p2,v1)
                in 
                    if remove_zeroes(v2,0,String.size(v2)) = "0" then (remove_zeroes(v2,0,String.size(v2)),remove_zeroes(v3,0,String.size(v3)))
                    else ("~" ^ remove_zeroes(v2,0,String.size(v2)),remove_zeroes(v3,0,String.size(v3)))
                end
        end
    fun rat(i)=
        SOME (remove_zeroes(i,0,String.size(i)),"1")
    (* val reci: string -> (string,string) option *)
    fun reci(p)=
        if remove_zeroes(p,0,String.size(p))="0" then  raise rat_error
        else if sign(p)=1 then SOME ("1",remove_zeroes(p,0,String.size(p)))
        else SOME ("~1",remove_zeroes(String.extract(p,1,NONE),0,String.size(String.extract(p,1,NONE))))
        handle rat_error=>NONE 
    fun neg((p,q))=
        let val v1=make_rat_copy(p,q) in
            if sign(#1(v1))=1 orelse sign(#1(v1))=0 then ("~" ^ #1(v1),#2(v1))
            else (String.extract(#1(v1),1,NONE),#2(v1))
        end
    fun inverse_copy((p1,q1))=
        let val (p,q)= make_rat_copy(p1,q1) 
        in  if remove_zeroes(p,0,String.size(p))="0" then ("","")
            else if sign(p)= ~1 then ("~" ^ q, String.extract(p,1,NONE))
            else (q,p)
        end
    fun inverse((p1,q1))=
        let val (p,q)= make_rat_copy(p1,q1) 
        in  if remove_zeroes(p,0,String.size(p))="0" then raise rat_error
            else if sign(p)= ~1 then SOME ("~" ^ q, String.extract(p,1,NONE))
            else SOME (q,p)
        end
        handle rat_error=>NONE
    fun equal((p1,q1),(p2,q2))=
        let val v1=make_rat_copy(p1,q1)
            val v2=make_rat_copy(p2,q2)
        in
            if v1=v2 then true
            else false
        end
    fun lcm(p,q)=
        let val v1=gcd(p,q)
            val v2=multiply_int(p,q)
        in
            division(v2,v1)
        end
    fun less((p1,q1),(p2,q2)) = 
        let val l1 = make_rat_copy(p1,q1)
            val l2 = make_rat_copy(p2,q2)
            val l3=lcm(#2(l1),#2(l2))
            val l4=division(l3,#2(l1))
            val l5=division(l3,#2(l2))
            val l6=(multiply_int(#1(l1),l4),l3)
            val l7=(multiply_int(#1(l2),l5),l3)
        in 
            less_int(#1(l6),#1(l7))
        end
    fun add((p1,q1),(p2,q2))=
        let val l1 = make_rat_copy(p1,q1)
            val l2 = make_rat_copy(p2,q2)
            val l3=lcm(#2(l1),#2(l2))
            val l4=division(l3,#2(l1))
            val l5=division(l3,#2(l2))
            val l6=(multiply_int(#1(l1),l4),l3)
            val l7=(multiply_int(#1(l2),l5),l3)
        in 
            make_rat_copy(add_int(#1(l6),#1(l7)),l3)
        end
    fun subtract((p1,q1),(p2,q2))=
        let val l1 = make_rat_copy(p1,q1)
            val l2 = make_rat_copy(p2,q2)
            val l3=lcm(#2(l1),#2(l2))
            val l4=division(l3,#2(l1))
            val l5=division(l3,#2(l2))
            val l6=(multiply_int(#1(l1),l4),l3)
            val l7=(multiply_int(#1(l2),l5),l3)
        in 
            make_rat_copy(sub(#1(l6),#1(l7)),l3)
        end
    fun multiply((p1,q1),(p2,q2))=
        make_rat_copy(multiply_int(p1,p2),multiply_int(q1,q2))
    fun divide((p1,q1),(p2,q2))=
        let val v1=inverse_copy((p2,q2)) in if v1=("","") then raise rat_error else 
        let val v2=multiply((#1(v1),#2(v1)),(p1,q1)) 
        in
            SOME v2 
        end
        end 
        handle rat_error=> NONE
    fun showRat((p,q))=
        let val (v1,v2) = make_rat_copy(p,q)
        in v1^"/"^v2 end
    fun count_after_dec(dec,count,i,flag)=
        if String.substring(dec,i,1)="(" then count
        else if String.substring(dec,i,1)="." then count_after_dec(dec,count,i+1,true)
        else if flag=true then count_after_dec(dec,count+1,i+1,flag)
        else count_after_dec(dec,count,i+1,flag)
    fun count_between(dec,count,i,flag)=
        if String.substring(dec,i,1)=")" then count
        else if String.substring(dec,i,1)="(" then count_between(dec,count,i+1,true)
        else if flag=true then count_between(dec,count+1,i+1,flag)
        else count_between(dec,count,i+1,flag)
    fun get_index(dec,sym,i)=
        if String.substring(dec,i,1) = sym then i 
        else get_index(dec,sym,i+1) 
    fun get_index_list(dec,sym,i)=
        if hd(dec) = sym then i 
        else get_index_list(tl(dec),sym,i+1) 
    fun add_zeroes(dec,c,i)=
        if i=c then dec
        else remove_zeroes(add_zeroes(dec^"0",c,i+1),0,String.size(add_zeroes(dec^"0",c,i+1)))
    fun fromDecimal_helper(dec,sign)=
        if String.isSubstring "(0)" dec then 
            let val c=count_after_dec(dec,0,0,false) 
                val ind=get_index(dec,".",0)
                val s1=String.substring(dec,0,ind)^String.substring(dec,ind+1,c)
                val s2=add_zeroes("1",c,0)
            in 
                if sign = true then make_rat_copy(s1,s2)
                else make_rat_copy("~" ^ s1,s2)
            end
        else
            let val c1=count_after_dec(dec,0,0,false)
                val c2=count_between(dec,0,0,false)
                val ind=get_index(dec,".",0)
                val l1=add_zeroes("1",c1,0)
                val l2=add_zeroes("1",c1+c2,0)
                val l3=sub(l2,l1)
                val l4=String.substring(dec,0,ind)^String.substring(dec,ind+1,c1)^String.substring(dec,ind+2+c1,c2)
                val l5=String.substring(dec,0,ind)^String.substring(dec,ind+1,c1)
                val l6=sub(l4,l5)
            in 
                if sign = true then make_rat_copy(l6,l3)
                else make_rat_copy("~" ^ l6,l3)
            end
    fun fromDecimal(dec)=
        if String.substring(dec,0,1) = "~" then fromDecimal_helper(String.extract(dec,1,NONE),false)
        else if String.substring(dec,0,1) = "+" then fromDecimal_helper(String.extract(dec,1,NONE),true)
        else fromDecimal_helper(dec,true)

    fun toDecimal_helper((p,q),rem_list,quo_str)=
        let val remainder=modulus(p,q) 
            val quot=division(p,q)
            val quo_st=quo_str^quot
        in
            if remove_zeroes(remainder,0,String.size(remainder))="0" then 
            if sign(p)=0 then "(0)" else quo_st^"(0)"
            (* else if String.isSubstring remainder rem_str then *)
            else if List.exists(fn x => x = remainder) rem_list then 
                let 
                    val ind=get_index_list(rem_list,remainder,0) 
                in 
                    String.substring(quo_st,0,ind) ^ "(" ^ String.extract(quo_st,ind,NONE)^")"
                end
            else toDecimal_helper((remainder^"0",q),rem_list@[remainder],quo_st)
        end
    fun toDecimal((p1,q1))=
        let val (p,q)=make_rat_copy(p1,q1) in
        if sign(p)=0 then "0.(0)"
        else if sign(p)=1 then 
            let val ans=division(p,q)
                val rem=modulus(p,q)
            in 
                ans^"." ^ toDecimal_helper((rem^"0",q),[rem],"")
            end
        else 
            let val p_new=String.extract(p,1,NONE)
                val ans=division(p_new,q)
                val rem=modulus(p_new,q)
            in 
                "~" ^ ans^"." ^ toDecimal_helper((rem^"0",q),[rem],"")
            end
        end
    fun showDecimal((p1,q1))=
        toDecimal ((p1,q1))
    end;
structure Rational = Myfunctor(Bigint)

