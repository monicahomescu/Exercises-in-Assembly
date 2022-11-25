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
    b dw 1001_1011_1011_1110b
    c dd 0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        ;Given the words A and B, compute the doubleword C as follows:
        ;the bits 0-3 of C are the same as the bits 5-8 of B
        ;the bits 4-8 of C are the same as the bits 0-4 of A
        ;the bits 9-15 of C are the same as the bits 6-12 of A
        ;the bits 16-31 of C are the same as the bits of B
        
        ;we compute the result in eax
        mov eax, 0
        
        ;we isolate bits 5-8 of B
        mov ebx, [b]
        and ebx, 0000_0000_0000_0000_0000_0001_1010_0000b
        
        ;we rotate 5 positions to the right
        mov cl, 5
        ror ebx, cl
        
        ;we put the bits into the result
        or eax, ebx

        ;we isolate bits 0-4 of A
        mov ebx, [a]
        and ebx, 0000_0000_0000_0000_0000_0000_0001_0111b
        
        ;we rotate 4 positions to the left
        mov cl, 4
        rol ebx, cl
        
        ;we put the bits into the result
        or eax, ebx
        
        ;we isolate bits 6-12 of A
        mov ebx, [a]
        and ebx, 0000_0000_0000_0000_0001_0111_0100_0000b
        
        ;we rotate 3 positions to the left
        mov cl, 3
        rol ebx, cl
        
        ;we put the bits into the result
        or eax, ebx
        
        ;we isolate all bits of B
        mov ebx, [b]
        and ebx, 0000_0000_0000_0000_1001_1011_1011_1110b
        
        ;we rotate 16 positions to the left
        mov cl, 16
        rol ebx, cl
        
        ;we put the bits into the result
        or eax, ebx
        
        ;eax = 1001_1011_1011_1110_1011_1011_0111_1101 / 9BBEBB7D
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
