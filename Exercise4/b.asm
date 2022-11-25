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
    
    s dd 12345678h, 1256ABCDh, 12AB4344h    ;the string of doublewords
    l equ ($-s)/4   ;the lenght of the string
    d times l dw 0  ;the new string for the result

; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        ;A string of doublewords is given. Order in decreasing order the string of the low words (least significant) from these doublewords. The high words (most significant) remain unchanged.
        ;Example:
        ;being given
            ;sir DD 12345678h 1256ABCDh, 12AB4344h
        ;the result will be
            ;1234ABCDh, 12565678h, 12AB4344h.
            
        mov esi, s  ;we store in esi the offset of source string s
        mov edi, d  ;we store in edi the offset of destination string d
        mov ecx, l  ;we put the length l in ECX in order to make the loop
        cld   ;we parse string from left to right
        
        rep_1:
            movsd   ;we put in edi the doublewords from s
        loop rep_1
            
        mov dx, 1   
        repeat_while:
            cmp dx, 0
            je end_while     ;if dx=0 we jump to end_while
            
            mov esi, d      ;we store in esi the offset of d
            mov dx, 0       ;we assume that no changes were made
            mov ecx, l-1     ;we put the length l-1 in ECX in order to make the loop
            
            repeat_for:
                mov ax, [esi]   
                cmp ax, [esi+4]     ;we compare the low words of the current double words
                jae next    ;if the low words are already in decreasing order we jump to next
                    mov bx, [esi+4]     ;we switch the low words if they are not in decreasing order
                    mov [esi], bx
                    mov [esi+4], ax
                    mov dx, 1      ;we put in dx 1 to show that changes were made
                next:
                inc esi     ;we increase esi in order to jump to the next low word
                inc esi
                inc esi
                inc esi
                loop repeat_for
                jmp repeat_while
        end_while:
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
