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
    
    ;a - byte, b - word, c - double word, d - qword - Unsigned representation
    a db 5h
    b dw 3h
    c dd 7h
    d dq 1h

; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        ;(b+b)+(c-a)+d
        
        ;storing c in dx:ax -> dx:ax=c
        mov ax, word[c]
        mov dx, word[c+2]
        
        ;converting a into dd -> cx:bx=a
        mov bl, [a]
        mov bh, 0
        mov cx, 0
        
        ;calculating (c-a) -> dx:ax=(c-a)
        sub ax, bx
        sbb dx, cx
        
        ;calculating (b+b) and converting to dd -> cx:bx=(b+b)
        mov bx, [b]
        adc bx, [b]
        mov cx, 0;
        
        ;calculating (b+b)+(c-a) -> dx:ax=(b+b)+(c-a)
        add ax, bx
        adc dx, cx
        
        ;saving (b+b)+(c-a) in eax -> eax=(b+b)+(c-a)
        push dx
        push ax
        pop eax
        
        ;storing d in ecx:ebx -> ecx:ebx=d
        mov ebx, dword[d]
        mov ecx, dword[d+4]
        
        ;calculating (b+b)+(c-a)+d -> edx:eax=(b+b)+(c-a)+d
        mov edx, 0
        add eax, ebx
        adc edx, ecx
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
