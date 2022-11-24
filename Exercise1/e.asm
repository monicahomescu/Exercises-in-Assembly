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
    
    ;a,b,c-byte; d-doubleword; e-qword
    a db 2h
    b db 2h
    c db 4h
    d dd 4h
    e dq 7h

; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        ;2/(a+b*c-9)+e-d
        
        ;calculating b*c -> bx=b*c
        mov al, [b]
        mov dh, [c]
        mul dh
        mov bx, ax
        
        ;converting a -> ax=a
        mov al, [a]
        mov ah, 0
        
        ;calculating (a+b*c-9) -> bx=(a+b*c-9)
        add bx, ax
        sub bx, 9h
        
        ;calculating 2/(a+b*c-9) -> ax=2/(a+b*c-9)
        mov si, bx
        mov ax, 2h
        mov dx, 0     
        div si
        
        ;converting ax to dx:ax -> dx:ax=2/(a+b*c-9)
        mov dx,0
        
        ;saving 2/(a+b*c-9) in eax -> eax=2/(a+b*c-9)
        push dx
        push ax
        pop eax
        
        ;storing e in ecx:ebx -> ecx:ebx=e
        mov ebx, dword[e]
        mov ecx, dword[e+4]
        
        ;calculating 2/(a+b*c-9)+e -> ecx:ebx=2/(a+b*c-9)+e
        mov edx, 0
        add ebx, eax
        adc ecx, edx
        
        ;storing d in dx:ax -> dx:ax=d
        mov ax, word[d]
        mov dx, word[d+2]
        
        ;saving d in eax -> eax=d
        push dx
        push ax
        pop eax
        
        ;calculating 2/(a+b*c-9)+e-d -> ecx:ebx=2/(a+b*c-9)+e-d
        mov edx, 0
        sub ebx, eax
        sbb ecx, edx
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
