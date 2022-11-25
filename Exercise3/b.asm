bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    
    s1 db '1', '3', '6', '2', '3', '7'  ;the byte string S1
    l equ $-s1    ;the lenght of S1
    s2 db '6', '3', '8', '1', '2', '5'  ;the byte string S2
    d times l db 0    ;the string D that will contain the result

; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        ;Two byte strings S1 and S2 are given, having the same length. Obtain the string D so that each element of D represents the maximum of the corresponding elements from S1 and S2.
        ;Example:
            ;S1: 1, 3, 6, 2, 3, 7
            ;S2: 6, 3, 8, 1, 2, 5
            ;D: 6, 3, 8, 2, 3, 7
            
        mov ecx, l  ;we put the length l in ECX in order to make the loop
        mov esi, 0  ;we initialize with 0 the index of S1 and S2 at which we start
        jecxz End   ;we skip loop if ECX=0
        Repeat:
            mov al, [s1+esi] ;al=s1[esi]
            mov bl, [s2+esi] ;bl=s2[esi]
            cmp al, bl  ;we compare the two ascii codes
            jg et1  ;if the character from S1 is greater than the character from S2 we jump to et1
            mov [d+esi], bl ;we add the character from S2 to D
            et1:    
            jle et2 ;if the character from S1 is less or equal to the character from S2 we jump to et2
            mov [d+esi], al ;we add the character from S1 to D
            et2:
            inc esi ;we increase the index of S1 and S2
        loop Repeat
        End:
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
