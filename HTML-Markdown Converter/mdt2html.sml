(* --------------------------------------------------------------------------------------------------------------- *)
(* -------------------------------Removing new line chahracters and tabs------------------------------------------- *)
fun remove_newline(string)=
let val v0=String.substring(string,0 ,String.size(string)-1) in v0 end
fun stri_to_lis(lis,i,s)=
if i=List.length(lis) then s
else
    let val s0=List.nth(lis,i)
        val v=s^" "^s0
    in stri_to_lis(lis,i+1,v) end
fun remove_tabs(lis,i)=
if i=List.length(lis) then lis else  
let val vp=List.nth(lis,i)
in  if String.isPrefix "   " vp  then
        let val v0=String.substring(List.nth(lis,i),3,String.size(List.nth(lis,i))-3)
            val (l0,l1)=List.splitAt(lis,i-1)
            (* val v1=stri_to_lis(l0,0,"") *)
            val v2=remove_newline(List.nth(l1,0))
            val s0=v2^" "^v0
            val v4=List.update(l1,0,s0)
            val v5=l0@[" "^hd(v4)^" "]@tl(tl(v4))
        in remove_tabs(v5,i) end
    else remove_tabs(lis,i+1)
end
(* ------------------------------------------------------------------ *)
(* Given a file and a string, it writes that string in the file *)
fun fswrite(f,s)= 
let val outs = TextIO.openAppend f
in
    let val ss = TextIO.output(outs,s^" ")
    in TextIO.closeOut outs end
end
fun hash_count(s,i,c,to_be)=
    if i = String.size(s) then c
    else if String.substring(s,i,1)= to_be then hash_count(s,i+1,c+1,to_be)
    else c
(*  -----------------------------------------------HEADING----------------------------------------------------------- *)
(* ------------------------------------------------------------------------------------------------------------------- *)
fun headings(lis,i,c)=
    if i=List.length(lis) andalso c <> 0 then 
    let val v0=lis@["</h"^Int.toString(c)^">"]
    in v0 end 
    else if i=List.length(lis) then lis
    else
    let val c0=hash_count(List.nth(lis,i),0,0,"#")
        val c1=List.nth(lis,i)
    in
    if c0 < 7 then 
        if String.isPrefix "#" c1 then
            if c0 <> String.size(List.nth(lis,i)) then
            let val v0="<h"^Int.toString(c0)^"> "^String.substring(List.nth(lis,i),c0,String.size(List.nth(lis,i))-c0)
                val v1=List.update(lis,i,v0)
            in headings(v1,i+1,c0) end
            else
            let val v0="<h"^Int.toString(c0)^">"
                val v1=List.update(lis,i,v0)
            in headings(v1,i+1,c0) end
        else headings(lis,i+1,c)
    else
        if String.isPrefix "#" c1 then
            if c0 <> String.size(List.nth(lis,i)) then
            let val v0="<h6> "^String.substring(List.nth(lis,i),6,String.size(List.nth(lis,i))-6)
                val v1=List.update(lis,i,v0)
            in headings(v1,i+1,6) end
            else
            let val v0="<h6>"
                val v1=List.update(lis,i,v0)
            in headings(v1,i+1,6) end
        else headings(lis,i+1,c) end
fun index(str,i,symbol,out)=
if i=String.size(str) then out
else if String.substring(str,i,1)=symbol then index(str,i+1,symbol,out@[i])
else index(str,i+1,symbol,out)
(* --------------------------------BOLD----------------------------------------------------- *)
(* ------------------------------------------------------------------------------------------- *)
fun bold_new(lis,i,bool1)=
if i=List.length(lis) then lis
else
    let val kkk=List.nth(lis,i)
        val k0=index(kkk,0,"*",[])
    in 
        if List.length(k0)=4 then 
        let val s1=String.substring(kkk,0,List.nth(k0,0))^"<strong>"^String.substring(kkk,List.nth(k0,1)+1,List.nth(k0,2)-List.nth(k0,1)-1)^"</strong>"^String.substring(kkk,List.nth(k0,3)+1,String.size(kkk)-List.nth(k0,3)-1)
            val s2=List.update(lis,i,s1)
        in bold_new(s2,i+1,bool1) end
        else if List.length(k0)=2 andalso List.nth(k0,1)-List.nth(k0,0)=1 andalso bool1=true then
        let val s1=String.substring(kkk,0,List.nth(k0,0))^"</strong>"^String.substring(kkk,List.nth(k0,1)+1,String.size(kkk)-List.nth(k0,1)-1)
            val s2=List.update(lis,i,s1)
        in bold_new(s2,i+1,false) end
        else if List.length(k0)=2 andalso List.nth(k0,1)-List.nth(k0,0)=1 andalso bool1=false then
        let val s1=String.substring(kkk,0,List.nth(k0,0))^"<strong>"^String.substring(kkk,List.nth(k0,1)+1,String.size(kkk)-List.nth(k0,1)-1)
            val s2=List.update(lis,i,s1)
        in bold_new(s2,i+1,true) end
        else bold_new(lis,i+1,bool1) end
(* --------------------------------------ITALIC------------------------------------------------------------------- *)
(* --------------------------------------------------------------------------------------------------------- *)
fun italic(lis,i,bool1)=
if i=List.length(lis) then lis
else 
    let val kkk=List.nth(lis,i)
        val k0=index(kkk,0,"*",[])
    in
        if List.length(k0)=2 andalso List.nth(k0,1)-List.nth(k0,0) <> 1 then 
        let val s1=String.substring(kkk,0,List.nth(k0,0))^"<em>"^String.substring(kkk,List.nth(k0,0)+1,List.nth(k0,1)-List.nth(k0,0)-1)^"</em>"^String.substring(kkk,List.nth(k0,1)+1,String.size(kkk)-List.nth(k0,1)-1)
            val s2=List.update(lis,i,s1)
        in italic(s2,i+1,bool1) end
        else if List.length(k0)=1  andalso bool1=true then
        let val s1=String.substring(kkk,0,List.nth(k0,0))^"</em>"^String.substring(kkk,List.nth(k0,0)+1,String.size(kkk)-List.nth(k0,0)-1)
            val s2=List.update(lis,i,s1)
        in italic(s2,i+1,false) end
        else if List.length(k0)=1  andalso bool1=false then
        let val s1=String.substring(kkk,0,List.nth(k0,0))^"<em>"^String.substring(kkk,List.nth(k0,0)+1,String.size(kkk)-List.nth(k0,0)-1)
            val s2=List.update(lis,i,s1)
        in italic(s2,i+1,true) end
        else italic(lis,i+1,bool1) end
(* ------------------------------------------------UNDERLINE------------------------------------------------------------- *)
(* ----------------------------------------------------------------------------------------------------------------------- *)
fun connect(lis,i,s)=
if i= List.length(lis) then s
else if i= List.length(lis)-1 then connect(lis,i+1,s^List.nth(lis,i))
else connect(lis,i+1,s^List.nth(lis,i)^" ")
fun underline(lis,i)=
if i=List.length(lis) then
    let val v1=lis@[""]
    in v1 end
else if String.size(List.nth(lis,i)) <> 0 andalso String.substring(List.nth(lis,i),0,1)="_"
then let val p =List.nth(lis,i);
        val (l0,l1)=List.splitAt(lis,i)
        val help=String.tokens( fn c => c = #"_") p ;
        val p1 = [connect(help,0,"")]
        val v0 = l0@["<u>"]@p1@["</u>"]@tl(l1)
    in underline(v0,i+1) end
else
    let val con=List.update(lis,i,List.nth(lis,i))
    in underline(con,i+1) end
(* ----------------------------------------Horizontal Ruling-------------------------------------------------------- *)
(* ----------------------------------------------------------------------------------------------------------------- *)
fun rule(lis,i)=
if i=List.length(lis) then lis
else if String.size(List.nth(lis,i))=3 andalso String.substring(List.nth(lis,i),0,3)="---"  then
    let val (l0,l1) = List.splitAt(lis,i)
        val v1 = l0@["<hr>"]@tl(l1)
    in rule(v1,i+1) end
else if String.size(List.nth(lis,i))>3 andalso String.substring(List.nth(lis,i),0,3)="---"  then
    let val (l0,l1) = List.splitAt(lis,i)
        val appe = String.substring(hd(l1),3,String.size(List.nth(lis,i))-3)
        val v1 = l0@["<hr>"]@[appe]@tl(l1)
    in rule(v1,i+1) end
else rule(lis,i+1)
fun clear_help(s,i)=
if i = String.size(s)-1 then s
else
    if String.substring(s,i,2)="\n" then
        let val s1 =String.substring(s,i+2,String.size(s)-i-3)
        in clear_help(s1,i) end
    else s
(* -----------------------------------WRITE------------------------- *)
fun write(l,count,text)= (*Given a count , it appends the text count times*)
if count=0
then l else
let val p = l@[text] 
in write(p,count-1,text) end
(* -------------------------------------BLOCK--------------------------------- *)
(* --------------------------------------------------------------------------------------- *)
fun block(lis,c,output)=
let val c0=hash_count(List.nth(lis,0),0,0,">")
    val c1=List.nth(lis,0) in
if String.isPrefix ">" c1 andalso List.nth(lis,0) <> ">>\n" then
    let val v0=write([],c0,"<blockquote>")
        val v1=write([],c0,"</blockquote>")
        val p0=v0@[String.substring(List.nth(lis,0),c0,String.size(List.nth(lis,0))-c0)]@tl(lis)@v1
    in p0 end
else lis
end
fun check_digit(string,i,flag)=
if i=String.size(string)-1 andalso String.substring(string,i,1)="." andalso flag=true then true
else if i=String.size(string)-1 then false 
else if Char.isDigit(String.sub(string,i)) then check_digit(string,i+1,true)
else if String.sub(string,i)= #"." andalso flag=true then true
else check_digit(string,i+1,flag)
(* ------------------------------------------------------------------------------------------------------------- *)
(* ---------------------------ORDERED LISTS------------------------------------------------------------------- *)
fun implement_list(lis,i,bool1)=
if i=List.length(lis) andalso bool1=true then
    let val l0=lis@[["</ol>"]]
    in l0 end
else if i=List.length(lis) then lis
else if check_digit(List.nth(List.nth(lis,i),0),0,false)=true andalso bool1=false then
    let val l0=["<ol><li>"]@tl(List.nth(lis,i))@["</li>"]
        val l1=List.update(lis,i,l0)
    in implement_list(l1,i+1,true) end
else if check_digit(List.nth(List.nth(lis,i),0),0,false)=true andalso bool1=true then
    let val l0=["<li>"]@tl(List.nth(lis,i))@["</li>"]
        val l1=List.update(lis,i,l0)
    in implement_list(l1,i+1,true) end
else if bool1=true then 
    let val l0=["</ol>"]@tl(List.nth(lis,i))
        val l1=List.update(lis,i,l0)
    in implement_list(l1,i+1,false) end
else implement_list(lis,i+1,bool1)
(* -----------------------------------------UNORDERED LISTS------------------------------------------------------ *)
fun unordered_list(lis,i,bool1)=
if i=List.length(lis) andalso bool1=true then
    let val l0=lis@[["</ul>"]]
    in l0 end
else if i=List.length(lis) then lis
else if (List.nth(List.nth(lis,i),0)="-"  orelse List.nth(List.nth(lis,i),0)="+" orelse List.nth(List.nth(lis,i),0)="*") andalso bool1=false then
    let val l0=["<ul><li>"]@tl(List.nth(lis,i))@["</li>"]
        val l1=List.update(lis,i,l0)
    in unordered_list(l1,i+1,true) end
else if (List.nth(List.nth(lis,i),0)="-"  orelse List.nth(List.nth(lis,i),0)="+" orelse List.nth(List.nth(lis,i),0)="*") andalso bool1=true then
    let val l0=["<li>"]@tl(List.nth(lis,i))@["</li>"]
        val l1=List.update(lis,i,l0)
    in unordered_list(l1,i+1,true) end
else if bool1=true then
    let val l0=["</ul>"]@List.nth(lis,i)
        val l1=List.update(lis,i,l0)
    in unordered_list(l1,i+1,false) end
else
    unordered_list(lis,i+1,bool1)
fun insert_td(lis,i)=
if i=List.length(lis) then lis
else
    let val v0="<td>"^List.nth(lis,i)^"</td>"
        val v1=List.update(lis,i,v0)
    in insert_td(v1,i+1) end
(* ----------------------------------------------------------------------------------------------------- *)
(* -----------------------------------------TABLES------------------------------------------------------- *)
fun tables(lis,i,bool1)=
if i=List.length(lis) andalso bool1=true then
let val l0=lis@[["</table>"]] in l0 end
else if i=List.length(lis) then lis
else if List.nth(lis,i)=[">>\n"] andalso bool1=true then 
let val v0=List.nth(lis,i)@["</table>"]
    val v1=List.update(lis,i,v0)
in v1 end
else if List.nth(lis,i)=["<<\n"] andalso bool1=false
then let val l0=["<table style=margin-left:auto;margin-right:auto;>\n>"]@tl(List.nth(lis,i))
        val l1=List.update(lis,i,l0)
    in tables(l1,i+1,true) end
else if bool1=true then
    let val l0=List.nth(lis,i)
        val l00=stri_to_lis(l0,0,"")
        val l1=String.tokens(fn c=> c = #"|") l00
        val l2=insert_td(l1,0)
        val l4=["<tr>"]@l2@["</tr>"]
        val l3=List.update(lis,i,l4)
    in tables(l3,i+1,true) end
else
    tables(lis,i+1,bool1)
(* -------------------------------------------------------------------------------------------------------------- *)
(* ---------------------------------------LINKS------------------------------------------------------------------ *)
fun make_links(s1,s2,l1)=
if s2 <> "" then
    let val cv=stri_to_lis(l1,0,"")
        val ans=["<a href="^s1^"title="^s2^">"^cv^"</a>\n"]
    in ans end
else
    let val cv=stri_to_lis(l1,0,"")
        val ans=["<a href="^s1^">"^cv^"</a>\n"]
    in ans end
fun concat(ident0,ident1,i,lis,s1,bool1)=
if i=List.length(lis) then s1
else if List.nth(lis,i)= ident0 then concat(ident0,ident1,i+1,lis,s1,true)
else if List.nth(lis,i)=ident1 then s1
else if bool1 then
    let val s0 =Char.toString(List.nth(lis,i))
        val s = s1^s0
    in concat(ident0,ident1,i+1,lis,s,true) end
else
    concat(ident0,ident1,i+1,lis,s1,bool1)
fun links(lis,i)=
if i =  List.length(lis) then lis
else
let val p = List.nth(lis,i)
in  if String.isPrefix "<http:" p =false andalso String.isPrefix " <a href=" p = false andalso String.isPrefix "[" p then
    let val up1=stri_to_lis(lis,0,"")
        val up=String.explode(up1)
        val u0=concat(#"[",#"]",0,up,"",false)
        val u1=concat(#"(",#")",0,up,"",false)
        val u2=String.tokens(fn c=> c= #" ") u1
    in  if List.length(u2)=0 then
        (* let val u3=make_links("","",[u0])
        in u3 end *)
        links(lis,i+1)
        else if List.length(u2) = 1 then
        let val u3=make_links(List.nth(u2,0),"",[u0])
        in u3 end
        else
        let val u3=make_links(List.nth(u2,0),List.nth(u2,1),[u0])
        in u3 end
    end
    else
        links(lis,i+1) end 
(* ------------------------------------------AUTOMATIC LINKS---------------------------------------------------- *)
(* ------------------------------------------------------------------------------------------------------------- *)
fun auto_links(lis,i)=
if i=List.length(lis) then lis
else
    let val v0=List.nth(lis,i)
        val v1="<http://"
    in if String.isPrefix v1 v0 then
            let val p0=String.substring(v0,1,String.size(v0)-2)
                val pp=make_links(p0,"",[p0])
                (* val p0=stri_to_lis(pp,0,"") *)
                val pp0=List.update(lis,i,List.nth(pp,0))
            in auto_links(pp0,i+1) end
        else
            auto_links(lis,i+1) end
(* ----------------------------------------READING INPUT--------------------------------------------------------- *)
fun readlist (infile : string) = let
  val ins = TextIO.openIn infile
  fun loop ins =
   case TextIO.inputLine ins of
      SOME line => line :: loop ins
    | NONE      => []
    in loop ins before TextIO.closeIn ins end
fun new(l)=
let val fp=String.tokens(fn c=> c = #" ") l in fp end 
(* -------------------------------------------BREAKING A LIST INTO LIST OF LISTS------------------------------------------------------- *)
fun help1(li,i,add_list)=
if i=List.length(li) then add_list
else
    let val q = List.nth(li,i)
        val p=new(q)
    in help1(li,i+1,add_list@[p]) end
(* --------------------GIVEN A LIST IT WRITES IN A FILE-------------------------------- *)
fun write_list(l,i)=
if i=List.length(l) then
    fswrite("filename.html","")
else
    let val p=fswrite("filename.html",List.nth(l,i))
    in write_list(l,i+1) end
(* ------------------------------MAIN PART OF THE FUNCTION WHERE EVERY FUNCTION IS BEING CALLED------------------------------------------------------ *)
fun main_support_2(list_of_list)=
let val q0 = implement_list(list_of_list,0,false)
    val q1 = unordered_list(q0,0,false)
    val q2 = tables(q1,0,false)
in q2 end
fun main_support(list_of_list,i)=
if i=List.length(list_of_list) then
    list_of_list
else
    let val p1=headings(List.nth(list_of_list,i),0,0)
        val p7=links(p1,0)
        val p8=auto_links(p7,0)
        val p2=block(p8,0,[])
        val p3=bold_new(p2,0,false)
        val p4=italic(p3,0,false)
        val p5=underline(p4,0)
        val p6=rule(p5,0) 
        val p9=write_list(p6,0)
    in main_support(list_of_list,i+1) end
fun mdt2html(fil)=
let val p0=fswrite("filename.html","<html><style>table, th, td {border:1px solid black;}</style><body>\n")
    val p1=readlist(fil)
    val p11=remove_tabs(p1,0)
(* in  write_list(p11,0) *)
    val p2=help1(p11,0,[])
    val p3= main_support_2(p2)
    val p4=main_support(p3,0)
in fswrite("filename.html","</body> </html>") end

