Grammar for Rational Numbers
 RatNum := [Sign]{Digit} | [Sign]{Digit} DecimalPoint {Digit} LeftParen Digit{Digit} RightParen | LeftParen [Sign] Digit{Digit} Separator {Digit} PosDigit {Digit} RightParen
 LeftParen := "("
 RightParen := ")"
 DecimalPoint := "."
 Digit := "0"|"1"|"2"|"3"|"4"|"5"|"6"|"7"|"8"|"9"
 Sign :=  "+"|"~"
 Separator := ","
 PosDigit := "1"|"2"|"3"|"4"|"5"|"6"|"7"|"8"|"9"

Grammar for Rational Expressions 
RatExp := RatExp AddOp NewRatExp | RatExp SubOp NewRatExp | NewRatExp
NewRatExp := NewRatExp MulOp RatTerm | RatTerm
RatTerm := RatTerm DivOp RatNum | RatNum
RatNum := [Sign]{Digit} | [Sign]{Digit} DecimalPoint {Digit} LeftParen Digit{Digit} RightParen | LeftParen [Sign] Digit{Digit} Separator {Digit} PosDigit {Digit} RightParen
AddOp := "+"
SubOp := "-"
MulOp := "*"
DivOp := "/"
LeftParen := "("
RightParen := ")"
DecimalPoint := "."
Digit := "0"|"1"|"2"|"3"|"4"|"5"|"6"|"7"|"8"|"9"
Sign :=  "+"|"~"
Separator := ","
PosDigit := "1"|"2"|"3"|"4"|"5"|"6"|"7"|"8"|"9"


Decision and Pragmatic Decisions for signature BIGINT:
Design Decisions:

This code defines a signature BIGINT that specifies a set of operations on big integers represented as strings.
The type bigint is an alias for the string type.
An exception bigint_error is defined to handle any errors related to the implementation of the operations.

Operations:

negate function takes a bigint and returns its negation as a bigint.
add_int function takes two bigints and returns their sum as a bigint.
sub function takes two bigints and returns their difference as a bigint.
multiply_int function takes two bigints and returns their product as a bigint.
division function takes two bigints and returns their quotient as a bigint.
modulus function takes two bigints and returns their remainder as a bigint.
sign function takes a bigint and returns its sign as a Int.int value (-1, 0, or 1).
sameSign function takes two bigints and returns true if they have the same sign, false otherwise.
greater function takes two bigints and returns true if the first is greater than the second, false otherwise.
greater_e function takes two bigints and returns true if the first is greater than or equal to the second, false otherwise.
less_int function takes two bigints and returns true if the first is less than the second, false otherwise.
less_e function takes two bigints and returns true if the first is less than or equal to the second, false otherwise.

Pragmatic Decisions:

The operations are defined as pure functions that take their inputs and return their outputs without any side effects.
The bigint type is represented as a string for simplicity and ease of use.
The sign function returns -1, 0, or 1 instead of a string or boolean value to make it easier to use the results in numerical computations.
The operations greater, greater_e, less_int, and less_e are defined in terms of each other to reduce code duplication.


Decision and Pragmatic Decisions for Myfunctor:

Design:

The Myfunctor functor takes in a BIGINT module as an argument, which is used to perform arithmetic operations on rational numbers.
A rational number is represented as a pair of bigint values, where the first value is the numerator and the second value is the denominator.
The make_rat function constructs a rational number from a pair of bigint values and returns it wrapped in an option type.
The rat function constructs a rational number from a single bigint value and returns it wrapped in an option type.
The reci function takes in a bigint value and returns the reciprocal of that value as a rational number wrapped in an option type.
The neg function takes in a rational number and returns its negation.
The inverse function takes in a rational number and returns its inverse (reciprocal) wrapped in an option type.
The equal function takes in a pair of rational numbers and returns true if they are equal, false otherwise.
The less function takes in a pair of rational numbers and returns true if the first number is less than the second, false otherwise.
The add function takes in a pair of rational numbers and returns their sum as a rational number.
The subtract function takes in a pair of rational numbers and returns their difference as a rational number.
The multiply function takes in a pair of rational numbers and returns their product as a rational number.
The divide function takes in a pair of rational numbers and returns their quotient as a rational number wrapped in an option type.
The showRat function takes in a rational number and returns its string representation.
The showDecimal function takes in a rational number and returns its decimal representation as a string.
The fromDecimal function takes in a string representing a decimal number and returns the corresponding rational number.
The toDecimal function takes in a rational number and returns its decimal representation as a string.
Pragmatic decisions:

The BIGINT module is assumed to contain functions for arithmetic operations on bigint values, including negation, addition, subtraction, multiplication, division, and modulus.
The make_rat function returns the constructed rational number wrapped in an option type to handle the case where the denominator is zero.
The rat function is provided to simplify the construction of rational numbers when the denominator is 1.
The reci function returns the reciprocal of the input value wrapped in an option type to handle the case where the input value is zero.
The inverse and divide functions return their result wrapped in an option type to handle the case where the denominator of the result is zero.
The showRat function returns the string representation of the rational number in the form "numerator/denominator".
The showDecimal function uses floating point arithmetic to compute the decimal representation of the rational number.
The fromDecimal function uses floating point arithmetic to convert the input string to a rational number.
The toDecimal function uses floating point arithmetic to compute the decimal representation of the rational number.
In addition to, I have also dealt with the stirngs containing leading zeroes as valid inputs. All the functions defined above give correct outputs for such inputs .
