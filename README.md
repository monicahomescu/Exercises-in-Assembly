# Exercises-in-Assembly

### Exercise 1

Additions, substractions

a. (b+b)+(c-a)+d   (a - byte, b - word, c - double word, d - qword - Unsigned representation)\
b. (d+d)-a-b-c   (a - byte, b - word, c - double word, d - qword - Unsigned representation)\
c. (c+b)-a-(d+d)   (a - byte, b - word, c - double word, d - qword - Signed representation)\
d. (d-b)-a-(b-c)   (a - byte, b - word, c - double word, d - qword - Signed representation)

Multiplications, divisions - Unsigned representation and signed representation

e. 2/(a+b*c-9)+e-d   (a,b,c-byte; d-doubleword; e-qword)\
f. (a+b*c+2/c)/(2+a)+e+x   (a,b-byte; c-word; e-doubleword; x-qword)\
g. 2/(a+b*c-9)+e-d   (a,b,c-byte; d-doubleword; e-qword)\
h. (a+b*c+2/c)/(2+a)+e+x   (a,b-byte; c-word; e-doubleword; x-qword)

### Exercise 2

a. Given the words A and B, compute the doubleword C as follows:\
-the bits 0-3 of C are the same as the bits 5-8 of B\
-the bits 4-8 of C are the same as the bits 0-4 of A\
-the bits 9-15 of C are the same as the bits 6-12 of A\
-the bits 16-31 of C are the same as the bits of B

b. Given the word A and the byte B, compute the doubleword C:\
-the bits 0-3 of C have the value 1\
-the bits 4-7 of C are the same as the bits 0-3 of A\
-the bits 8-13 of C have the value 0\
-the bits 14-23 of C are the same as the bits 4-13 of A\
-the bits 24-29 of C are the same as the bits 2-7 of B\
-the bits 30-31 have the value 1

### Exercise 3

a. Given a character string S, obtain the string D containing all special characters (!@#$%^&*) of the string S.\
Example:\
S: '+', '4', '2', 'a', '@', '3', '$', '*'\
D: '@','$','*'

b. Two byte strings S1 and S2 are given, having the same length. Obtain the string D so that each element of D represents the maximum of the corresponding elements from S1 and S2.\
Example:\
S1: 1, 3, 6, 2, 3, 7\
S2: 6, 3, 8, 1, 2, 5\
D: 6, 3, 8, 2, 3, 7

### Exercise 4

a. An array of words is given. Write an asm program in order to obtain an array of doublewords, where each doubleword will contain each nibble unpacked on a byte (each nibble will be preceded by a 0 digit), arranged in an ascending order within the doubleword.\
Example:\
for the initial array: 1432h, 8675h, 0ADBCh, ...\
the following should be obtained: 01020304h, 05060708h, 0A0B0C0Dh, ...
