1-subsequence(S,L)
Input-
The predicate takes two arguments: a list S and a list L. It checks whether the list S is a subsequence of L, meaning that the elements of S occur in L in the same order, but not necessarily successively.
Output-
The output of the subsequence/2 predicate is a boolean value: true if S is a subsequence of L, and false otherwise. 
Functionality-
The predicate has three rules:

The first rule defines the base case for the recursion. It states that an empty list is a subsequence of any list.
The second rule checks if the head of the first list S is equal to the head of the second list L. If they are equal, the predicate recursively checks if the tail of S is a subsequence of the tail of L. This rule captures the case when the first element of S matches the first element of L.
The third rule handles the case when the first element of S does not match the first element of L. It recursively checks if S is a subsequence of the tail of L. This rule captures the case when the first element of S does not match the first element of L.
The predicate can be used by calling it with two lists as arguments, for example:

?- subsequence([a,c,e], [a,b,c,d,e]).
true.

?- subsequence([a,c,e], [a,b,d,e]).
false.
In the first example, the predicate returns true because the elements "a", "c", and "e" occur in the same order, but not necessarily successively, in the list "a,b,c,d,e". In the second example, the predicate returns false because the element "c" is missing from the second list.


2- has_no_triplicates(L)
Input-
The predicate takes one argument: a list L. It checks whether the list L contains three or more copies of any element.
Output-
The output of the has_no_triplicates/1 predicate is a boolean value: true if the list L does not contain three or more copies of any element, and false otherwise.
Functionality-
The predicate has two rules:
The first rule defines the base case for the recursion. It states that an empty list does not contain three or more copies of any element.
The second rule checks if the head of the list L appears two or fewer times in the tail of the list L. It recursively checks the tail of L to see if any other element appears three or more times. If the head of the list appears three or more times, or if any other element appears three or more times, the predicate returns false. Otherwise, it continues recursively checking the rest of the list.
 The predicate can be used by calling it with a single list argument, for example:

?- has_no_triplicates([1, 2, 3, 4, 5]).
true.

?- has_no_triplicates([1, 2, 2, 3, 3, 3, 4, 4, 4, 4]).
false.
In the first example, the predicate returns true because the list does not contain any element that appears three or more times. In the second example, the predicate returns false because the element "4" appears four times in the list.


3-arith(L)
Input:
The input to the function "arith" is a list of integers .

Output:
The output of the function "arith" is a string that represents a correct equation with arithmetic operators inserted in the appropriate places. It can give all possible equations possible, but I have inserted a ! operator to end the function once a possible equation is printed since it was mentioned in the assignment to give a possible correct equation. ! operator can be removed in order to obtain all possible equations.

Functionality:
The "arith" function uses recursion to generate all possible combinations of arithmetic operator symbols (+, -, and =) and checks whether the resulting equation is valid. If the equation is valid, the function returns the equation as a string.

The function first generates all possible combinations of arithmetic operator symbols using the "generate_op" function. The function then checks whether there is only one "=" symbol in the list of arithmetic operator symbols using the "valid_count" function. If there is only one "=", the function finds the index of the "=" symbol using the "index_of" function.

The function then uses the "concat" function to split the list of integers into two parts based on the index of the "=" symbol and insert the appropriate arithmetic operators. The "concat" function takes six arguments: the two parts of the list of integers, the current position of the "=" symbol in the list of arithmetic operator symbols, a boolean value indicating whether the current integer should be added to the first or second part of the list, and two accumulator lists for the two parts of the equation. The "concat" function returns the two parts of the equation with the arithmetic operators inserted.

The function then checks whether the resulting equation is valid using the "correct_eq" function, which evaluates both sides of the equation and checks whether they are equal. If the equation is valid, the function concatenates the two parts of the equation into a single string using the "append" and "atomic_list_concat" functions.

Overall, the "arith" function generates all possible equations and returns the first valid equation it finds as a string.
?- arith([1,2,3,6]).
1+2+3=6
true

Ceratin specific cases - It prints an 'Empty list given' string as output in case an empty list is given as input. This code also may return equation containing a minus or plus sign in front of a negative integer which in turn gives equation containing two consecutive minus signs or a consecutive plus and minus signs.

4-abcd()
Input-
There is no input for this program. 
Output-
The program outputs the solution to the problem, which is a list of moves required to get all four people across the river. Each move is represented as a two-element list, where the first element is the direction of the move (left_to_right or right_to_left) and the second element is the list of people in the canoe during that move. For example, [[left_to_right,[alice,bob]], [right_to_left,[alice]], [left_to_right,[carol,davis]], [right_to_left,[bob]], [left_to_right,[bob,carol]]] represents the solution where Alice and Bob cross together first, followed by Alice crossing alone, then Carol and Davis crossing together, then Bob crossing alone, and finally Bob and Carol crossing together. The person firstly mentioned in this list is the paddler.
Functionality-
It defines a list representing the initial and final state of the problem. The list has two sublists, representing the left and right banks of the river. Each sublist contains the names of the people currently on that bank. For example, [[alice,bob,carol,davis],[]] represents the initial state where all four people are on the left bank and the right bank is empty.
The code defines several constraints to ensure that the solution is valid. The first constraint is that a move can only be made if it is valid. A move is valid if the direction of the move is from left to right and there are two people in the canoe, or if the direction of the move is from right to left and there is only one person in the canoe. The second constraint is that Alice cannot paddle when someone else is in the canoe with her. The third constraint is that Bob cannot paddle when anyone else but Carol is in the canoe with him. The fourth constraint is that each person must paddle for at least one crossing. The fifth constraint is that the solution must contain at least one move where each person paddles exactly once, and one move where one person paddles twice.
In addition to the solution, the program also outputs a message indicating which person paddled twice. For example, the output might be: "Bob paddled twice". If no one paddled twice, the program outputs nothing.
To find the solution, the program uses a depth-first search algorithm. It generates all possible valid moves from the current state, applies each move to generate a new state, and continues searching from the new state. The program keeps track of the path of moves taken from the initial state to the current state, as well as a list of visited states to avoid revisiting previously explored states. The program stops searching when it reaches a state that matches the final state, and returns the path of moves that led to that state.



