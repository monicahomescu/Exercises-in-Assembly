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
    
    s dw 1432h, 8675h, 0ADBCh   ;the array of words
    l equ ($-s)/2   ;the length of the arrary
    d times l dd 0   ;the new string for the result

; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        ;An array of words is given. Write an asm program in order to obtain an array of doublewords, where each doubleword will contain each nibble unpacked on a byte (each nibble will be preceded by a 0 digit), arranged in an ascending order within the doubleword.
        ;Example:
        ;for the initial array:
            ;1432h, 8675h, 0ADBCh, ...
        ;The following should be obtained:
            ;01020304h, 05060708h, 0A0B0C0Dh, ...
        
        mov esi, s    ;we store in esi the offset of source string s
        mov edi, d    ;we store in edi the offset of destination string d
        mov ecx, l    ;we put the length l in ECX in order to make the loop
        cld     ;we parse string from left to right
        
        rep_1:
        
            lodsb   ;we store in al the low byte of the word
            
            mov bl, al      ;we copy the byte in bl
            shr al, 4       ;we shift to the right with 4 positions to get the first nibble
            stosb       ;we store the result in edi
            
            mov al, bl      ;we put in al the copy
            shl al, 4       ;we shift to the left with 4 positions
            ror al, 4       ;we rotate to the right with 4 positions to get the second nibble
            stosb       ;we store the result in edi
            
            lodsb       ;we store in al the high byte of the word
            
            mov bl, al      ;we copy the byte in bl
            shr al, 4       ;we shift to the right with 4 positions to get the first nibble
            stosb       ;we store the result in edi
            
            mov al, bl      ;we put in al the copy
            shl al, 4       ;we shift to the left with 4 positions
            ror al, 4       ;we rotate to the right with 4 positions to get the second nibble
            stosb       ;we store the result in edi
           
        loop rep_1
        
        
        mov dx, 1
        repeat_while:
            cmp dx, 0
            je end_while    ;if dx=0 we jump to end_while
            
            mov esi, d      ;we store in esi the offset of d
            mov dx, 0       ;we assume that no changes were made
            mov ecx, l-1        ;we put the length l-1 in ECX in order to make the loop
            
            repeat_for:
                mov al, [esi]
                cmp al, [esi+1]
                jbe next
                    mov ah, [esi+1]
                    mov [esi], ah
                    mov [esi+1], al
                    mov dx, 1
                next:
                inc esi
                loop repeat_for
                jmp repeat_while
            
        end_while:

        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
