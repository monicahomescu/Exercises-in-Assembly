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
    
    s db '+42a@3$*' ;the character string S
    l equ $-s   ;the lenght of the string S
    d times l db 0  ;the string D that will contain the result

; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        ;Given a character string S, obtain the string D containing all special characters (!@#$%^&*) of the string S.
        ;Example:
            ;S: '+', '4', '2', 'a', '@', '3', '$', '*'
            ;D: '@','$','*'
            
        mov ecx, l  ;we put the length l in ECX in order to make the loop
        mov esi, 0  ;we initialize with 0 the index of S
        mov edi, 0  ;we initialize with 0 the index of D
        jecxz End   ;we skip loop if ECX=0
        Repeat:
            mov al, [s+esi] ;al=s[esi]
            
            mov bl, '!'
            cmp al, bl  ;we compare the character with '!'
            jne et1 ;if the two characters are not equal we jump to et1
            mov [d+edi], al ;we add the special character to D
            inc edi ;we increase the index of D
            et1:

            mov bl, '@'
            cmp al, bl  ;we compare the character with '@'
            jne et2 ;if the two characters are not equal we jump to et2
            mov [d+edi], al ;we add the special character to D
            inc edi ;we increase the index of D
            et2:

            mov bl, '#'
            cmp al, bl  ;we compare the character with '#'
            jne et3 ;if the two characters are not equal we jump to et3
            mov [d+edi], al ;we add the special character to D
            inc edi ;we increase the index of D
            et3:

            mov bl, '$'
            cmp al, bl  ;we compare the character with '$'
            jne et4 ;if the two characters are not equal we jump to et4
            mov [d+edi], al ;we add the special character to D
            inc edi ;we increase the index of D
            et4:

            mov bl, '%'
            cmp al, bl  ;we compare the character with '%'
            jne et5 ;if the two characters are not equal we jump to et5
            mov [d+edi], al ;we add the special character to D
            inc edi ;we increase the index of D
            et5:

            mov bl, '^'
            cmp al, bl  ;we compare the character with '^'
            jne et6 ;if the two characters are not equal we jump to et6
            mov [d+edi], al ;we add the special character to D
            inc edi ;we increase the index of D
            et6:

            mov bl, '&'
            cmp al, bl  ;we compare the character with '&'
            jne et7 ;if the two characters are not equal we jump to et7
            mov [d+edi], al ;we add the special character to D
            inc edi ;we increase the index of D
            et7:

            mov bl, '*'
            cmp al, bl  ;we compare the character with '*'
            jne et8 ;if the two characters are not equal we jump to et8
            mov [d+edi], al ;we add the special character to D
            inc edi ;we increase the index of D
            et8:
            
            inc esi ;we increase the index of S
        loop Repeat
        End:
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
