(* This function has been defined in order to deal with larger inputs.
It takes integer string(arr), running index(i), current carry(carr), len of arr - 1 (index) and product calculated so far(pr) and gives a string of integers 
containing the product of arr and i digit by digit *)
fun mul(arr,i,carr,index,pr)= 
if index= ~1
then
    pr
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
(* This function takes string of integers(arr), carry to be added(carr), running index(index),the sum calculated so far(sum) and gives the string 
of integers containing the sum of arr and carr *)
fun single_add(arr,carr,index,sum)=
if index= ~1
then
    sum
else
    if index=0
    then
        let
            val SOME partial_sum_h=Int.fromString(String.substring(arr,index,1));
            val partial_sum=partial_sum_h+carr;
            val new_carr=partial_sum div 10
            (* val new_sum=Int.toString(partial_sum mod 10)    *)
        in
            single_add(arr,new_carr,index-1,Int.toString(partial_sum)^sum)
        end
    else
        let
            val SOME partial_sum_h=Int.fromString(String.substring(arr,index,1));
            val partial_sum=partial_sum_h+carr;
            val new_carr=partial_sum div 10;
            val new_sum=Int.toString(partial_sum mod 10)   
        in
            single_add(arr,new_carr,index-1,new_sum^sum)
        end
(* This function takes two input strings of integers( arr1 and arr2 ), the carry to be added (carr), the running index (index) and the sum calculated so far(sum)
and the gives a string of integers containing the sum of arr1 and arr2 discarding the additional digit if produced *)
fun multi_adder(arr1,arr2,carr,index,sum)=
if index= ~1
then 
    sum
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
    (* This function has been defined inorder to produce the 9's complement of a given number
    It takes a string of integers (arr),index and the ans calculated so far(ans) and gives a string of integer which is the 9's complement of the given number *)
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
(* This function takes a string of integers(arr2) t, the required length of the string(i) and the original length of the string(p) and 
gives the string of integers of required length by concatenating required number of zeroes in the string *)
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
(* This multi_adder calls the previously defined multi_adder function by first making both the strings of equal length and then passing it as arguments to the multi_adder function 
defined above *)
fun multi_adder_final(num1,num2)=
let
    val s1=String.size(num1)
    val s2=String.size(num2)
in 
    if s1>=s2
    then 
        multi_adder(num1,make_equal(num2,s1,s2),0,s1-1,"")
    else
        multi_adder(make_equal(num1,s2,s1),num2,0,s2-1,"")
end
(*  This function takes two strings of integers (arr1 and arr2) and returns the string denoting the difference of the two strings
It basically uses the idea that difference of two numbers a-b is same as the addition of a with 10's complement of b*)
fun sub(arr1,arr2)=
let
    val k=String.size(arr2);
    val arr2f=make_equal(arr2,String.size(arr1),k);
    val com_h=complement(arr2f,String.size(arr2f)-1,"");
    val com=multi_adder_final(com_h,"1");
    val add=multi_adder_final(arr1,com)
in
    add
end
(* This function takes two strings of integers(num1 and num2) and returns a boolean value-> true in case num1 is greater than or equal to num2
 else false
 It compares every single bit recursively and outputs accordingly *)
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
(* This function takes two strings of integers(num1 and num2) and returns a boolean value-> true in case num1 is greater than num2
 else false
 It compares every single bit recursively and outputs accordingly *)
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
(* This function takes any string of integers as argument and outputs the result obtained by multiplying 10 to the given input *)
fun mul_10(num1)=
    let 
        val num1_f = num1^"0"
    in
        num1_f
    end
(* This function takes any string of integers as argument and outputs the result obtained by multiplying 100 to the given input *)
fun mul_100(num1)=
    let 
        val num1_f = num1^"00"
    in
        num1_f
    end    
(* It converts the two input strings into equal length and then passes this as input to compare_ge *)
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
(* It converts the two input strings into equal length and then passes this as input to compare_ge *)
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
(* This function appends any given input(x) to the given list(arr) *)
fun append(arr,x)=
if null(arr)
then
    [x] 
else 
    hd(arr) :: append(tl(arr),x)
(* This function takes a string as input and converts it into a list which stores every 
element of this string converted to integer at every index of the output list *)
fun str_to_list(s,arr,i)=
if i=String.size(s) 
then 
    arr 
else 
    let 
        val SOME a=Int.fromString(String.str(String.sub(s,i))) 
    in
        str_to_list(s,append(arr,a),i+1)
    end
(* This function takes a list(arr) as input and checks the length of the list,
 in case it is even it outputs the list as it is, else it appends 0 to the start of the list given as output  *)
fun check_len(arr)=
if List.length(arr) mod 2 =1
then 
    0::arr 
else
    arr;
(* This function takes a string as input and removes the trailing zeroes before the first non-zero digit and gives this modified string *)
fun remove_zeroes(s,i,p)=
if p= 0
then
    "0"
else if String.substring(s,i,1) <> "0"
then
    s
else
    remove_zeroes(String.substring(s,i+1,p-1),i,p-1)
(* This function takes two strings of integers (a1 and a2),two counters (low and high), and a list of integers(arr) as input
 This works similar to the standard binary search and finds a maximum possible number h such that (10*a1 + h)*h <= a2 *)
fun bin_search_helper(a1,a2,low,high,arr)=
let 
    val mid=(high+low) div 2;
    (* val a2_str = Int.toString(a2);  *)
    val a1_s=String.size(a1)
in 
    if high-low=2 orelse high-low=1 
    then 
        let

            val p=mul(single_add(mul_10(a1),List.nth(arr,mid),a1_s,""),List.nth(arr,mid),0,String.size(single_add(mul_10(a1),List.nth(arr,mid),a1_s,""))-1,"");
            val q=mul(single_add(mul_10(a1),List.nth(arr,low),a1_s,""),List.nth(arr,low),0,String.size(single_add(mul_10(a1),List.nth(arr,low),a1_s,""))-1,"");
            val r=mul(single_add(mul_10(a1),List.nth(arr,high),a1_s,""),List.nth(arr,high),0,String.size(single_add(mul_10(a1),List.nth(arr,high),a1_s,""))-1,"")
            
        in
            if compare_ge_final(a2,q) andalso compare_gt_final(p,a2)
            then 
                [Int.toString(List.nth(arr, low)),single_add(mul_10(a1),List.nth(arr,low),a1_s,"")] 
            else if compare_ge_final(a2,p) andalso compare_gt_final(r,a2)
            then 
                [Int.toString(List.nth(arr,mid)),single_add(mul_10(a1),List.nth(arr,mid),a1_s,"")]
            else 
                [Int.toString(List.nth(arr,high)),single_add(mul_10(a1),List.nth(arr,high),a1_s,"")] 
        end
    else if compare_gt_final(a2,mul((single_add(mul_10(a1),List.nth(arr,mid),a1_s,"")),List.nth(arr,mid),0,String.size(single_add(mul_10(a1),List.nth(arr,mid),a1_s,""))-1,""))
    then 

        bin_search_helper(a1,a2,mid,high,arr) 
    else 
        bin_search_helper(a1,a2,low,mid,arr) 
end
(* This function just calls the above defined bin_search_helper with arr input as the list
 of integers from zero to nine and high and low as 9 and 0 respectively*)
fun bin_search(s1,s2)=
let
    val A= [0,1,2,3,4,5,6,7,8,9]
in
    bin_search_helper(s1,s2,0,9,A)
end
(* This function takes the current dividend(r), current qoutient(q), current divisor(num), index from where the next pair needs to be considered(length) ,
 the length of the input number(l), and the input converted into the list of integers(str_list) as input
 It basically finds the nearest number(h) such that the (10*num + (h))*(h) <= r using bin_search defined above
  and this number than gets concatenated to the quotient. This is the updated value of q. Also it updates the value of r as r-(10*num + h)*h concatenated 
  with the next pair of the input divided in pairs just as we do in the long division method. Also the value of num gets updated to (num*10 + h+h).
  These updated values of num, r and q goes to next recursive call *)
fun int_sqrt_helper(r,q,num,length,l,str_list)=
if length=l+2
then
    (r,q)
else
    let 
        val ans= bin_search(num,r) ;
        val SOME multiplier= Int.fromString(List.nth(ans,0))
        val prod = mul(List.nth(ans,1),multiplier,0,String.size(List.nth(ans,1))-1,"");
        val dif = sub(r,prod)
        (* print(Int.toString(List.nth(ans,0))) *)
    in
        (* q=10*q + List.nth(ans,0); *)
        if l=length
        then
            int_sqrt_helper(dif,single_add(mul_10(q),multiplier,String.size(q),""),single_add(List.nth(ans,1),multiplier,String.size(List.nth(ans,1))-1,""),length+2,l,str_list)
        else
            int_sqrt_helper(single_add(multi_adder_final(mul_100(dif),mul_10(Int.toString(List.nth(str_list,length)))),List.nth(str_list,(length+1)),String.size(dif)+1,""),single_add(mul_10(q),multiplier,String.size(q),""),single_add(List.nth(ans,1),multiplier,String.size(List.nth(ans,1))-1,""),length+2,l,str_list)
    end
(* It takes a string as input and outputs the integer square root of the given number and the smallest number which must
 be subtracted from the given number in order to obtain the perfect square *)
fun isqrtld(s)=
let 
    val a1=str_to_list(s,[],0);
    val a2=check_len(a1)
    val (b0,b1)=int_sqrt_helper(single_add(mul_10(Int.toString(List.nth(a2,0))),List.nth(a2,1),String.size(mul_10(Int.toString(List.nth(a2,0))))-1,""),"","",2,List.length(a2),a2)

in
    (remove_zeroes(b1,0,String.size(b1)),remove_zeroes(b0,0,String.size(b0)))    
end

    

