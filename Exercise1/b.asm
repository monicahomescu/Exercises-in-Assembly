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
    a db 1h
    b dw 2h
    c dd 3h
    d dq 4h
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        ;(d+d)-a-b-c
        
        ;storing d in ecx:ebx -> ecx:ebx=d
        mov ebx, dword[d]
        mov ecx, dword[d+4]
        
        ;storing d in edx:eax -> edx:eax=d
        mov eax, dword[d]
        mov edx, dword[d+4]
        
        ;calculating (d+d) -> ecx:ebx=(d+d)
        add ebx, eax
        adc ecx, edx
        
        ;converting a into dd -> dx:ax=a
        mov al, [a]
        mov ah, 0
        mov dx, 0
        
        ;saving a in eax -> eax=a
        push dx
        push ax
        pop eax
        
        ;calculating (d+d)-a -> ecx:ebx=(d+d)-a
        mov edx, 0
        sub ebx, eax
        sbb ecx, edx
        
        ;converting b into dd -> dx:ax=b
        mov ax, [b]
        mov dx, 0;
        
        ;saving b in eax -> eax=b
        push dx
        push ax
        pop eax
        
        ;calculating (d+d)-a-b -> ecx:ebx=(d+d)-a-b
        mov edx, 0
        sub ebx, eax
        sbb ecx, edx
        
        ;storing c in dx:ax -> dx:ax=c
        mov ax, word[c]
        mov dx, word[c+2]
        
        ;saving c in eax -> eax=c
        push dx
        push ax
        pop eax
        
        ;calculating (d+d)-a-b-c -> ecx:ebx=(d+d)-a-b-c
        mov edx, 0
        sub ebx, eax
        sbb ecx, edx
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
