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
    
    a dw 0111_0111_0101_0111b
    b db 1001_1011b
    c dd 0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        ;Given the word A and the byte B, compute the doubleword C:
        ;the bits 0-3 of C have the value 1
        ;the bits 4-7 of C are the same as the bits 0-3 of A
        ;the bits 8-13 of C have the value 0
        ;the bits 14-23 of C are the same as the bits 4-13 of A
        ;the bits 24-29 of C are the same as the bits 2-7 of B
        ;the bits 30-31 have the value 1
        
        ;we compute the result in eax
        mov eax, 0
        
        ;we force the value of bits 0-3 to the value 1
        or eax, 0000_0000_0000_0000_0000_0000_0000_1111b
        
        ;we isolate bits 0-3 of A
        mov ebx, [a]
        and ebx, 0000_0000_0000_0000_0000_0000_0000_0111b
        
        ;we rotate 4 positions to the left
        mov cl, 4
        rol ebx, cl
        
        ;we put the bits into the result
        or eax, ebx
        
        ;we force the value of bits 8-13 to the value 0
        and eax, 0000_0000_0000_0000_0000_0000_0000_0000b
        
        ;we isolate bits 4-13 of A
        mov ebx, [a]
        and ebx, 0000_0000_0000_0000_0011_0111_0101_0000b
        
        ;we rotate 10 positions to the left
        mov cl, 10
        rol ebx, cl
        
        ;we put the bits into the result
        or eax, ebx
        
        ;we isolate bits 2-7 of B
        mov ebx, [b]
        and ebx, 0000_0000_0000_0000_0000_0000_1001_1000b
        
        ;we rotate 22 positions to the left
        mov cl, 22
        rol ebx, cl
        
        ;we put the bits into the result
        or eax, ebx
        
        ;we force the value of bits 30-31 to the value 1
        or eax, 1100_0000_0000_0000_0000_0000_0000_0000b
        
        ;eax = 1110_0110_1101_1101_0100_0000_0111_1111 / E6DD407F
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
