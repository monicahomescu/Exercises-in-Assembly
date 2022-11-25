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
