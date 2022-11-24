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
    
    ;a - byte, b - word, c - double word, d - qword - Signed representation
    a db 1h
    b dw 4h
    c dd 2h
    d dq 9h
    x resd 1

; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        ;(d-b)-a-(b-c)
        
        ;storing d in ecx:ebx -> ecx:ebx=d
        mov ebx, dword[d]
        mov ecx, dword[d+4]
        
        ;converting b into dd -> dx:ax=b
        mov ax, [b]
        cwd
        
        ;saving b in eax -> eax=b
        push dx
        push ax
        pop eax
        
        ;calculating (d-b) -> ecx:ebx=(d-b)
        mov edx, 0
        sub ebx, eax
        sbb ecx, edx
        
        ;converting a into dd -> dx:ax=a
        mov al, [a]
        cbw
        cwd
        
        ;saving a in eax -> eax=a
        push dx
        push ax
        pop eax
        
        ;calculating (d-b)-a -> ecx:ebx=(d-b)-a
        mov edx, 0
        sub ebx, eax
        sbb ecx, edx
        
        ;storing c in dx:ax -> dx:ax=c
        mov ax, word[c]
        mov dx, word[c+2]
        
        ;saving c
        mov [x+0], ax
        mov [x+2], dx
        
        ;converting b into dd -> dx:ax=b
        mov ax, [b]
        mov dx, 0;
        
        ;calculating (b-c) -> dx:ax=(b-c)
        sub ax, [x+0]
        sbb dx, [x+2]
        
        ;saving (b-c) in eax -> eax=(b-c)
        push dx
        push ax
        pop eax
        
        ;calculating (d-b)-a-(b-c) -> ecx:ebx=(d-b)-a-(b-c)
        mov edx, 0
        sub ebx, eax
        sbb ecx, edx
       
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
