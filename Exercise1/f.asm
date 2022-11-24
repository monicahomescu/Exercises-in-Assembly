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
    
    ;a,b-byte; c-word; e-doubleword; x-qword
    a db 1h
    b db 6h
    c dw 1h
    e dd 1h
    x dq 1h
    n resd 1

; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        ;(a+b*c+2/c)/(2+a)+e+x
        
        ;converting b -> ax=b
        mov al, [b]
        mov ah, 0
        
        ;calculating b*c -> dx:ax=b*c
        mov dx, [c]
        mul dx
        
        ;converting a -> cx:bx=a
        mov bl, [a]
        mov bh, 0
        mov cx, 0
        
        ;calculating a+b*c -> cx:bx=a+b*c
        add bx, ax
        adc cx, dx
        
        ;calculating 2/c -> ax=2/c
        mov si, [c]
        mov ax, 2h
        mov dx, 0
        div si
        
        ;calculating (a+b*c+2/c) -> cx:bx=(a+b*c+2/c)
        mov dx, 0
        add bx, ax
        adc cx, dx
        
        ;calculating (2+a) -> ax=(2+a)
        mov al, [a]
        add al, 2
        mov ah, 0
        
        ;calculating (a+b*c+2/c)/(2+a) -> ax=(a+b*c+2/c)/(2+a)
        mov si, ax
        mov ax, bx
        mov dx, cx
        div si
        
        ;converting ax to dx:ax -> dx:ax=(a+b*c+2/c)/(2+a)
        mov dx, 0
        
        ;storing 
        mov [n+0], ax
        mov [n+2], dx
        
        ;storing e in dx:ax -> dx:ax=e
        mov ax, word[e]
        mov dx, word[e+2]
        
        ;saving e in eax -> eax=e
        push dx
        push ax
        pop eax
        
        ;storing x in ecx:ebx -> ecx:ebx=x
        mov ebx, dword[x]
        mov ecx, dword[x+4]
        
        ;calculating e+x -> ecx:ebx=e+x
        mov edx, 0
        add ebx, eax
        adc ecx, edx
        
        mov ax, [n+0]
        mov dx, [n+2]
        
        ;saving (a+b*c+2/c)/(2+a) in eax -> eax=(a+b*c+2/c)/(2+a)
        push dx
        push ax
        pop eax
        
        ;calculating (a+b*c+2/c)/(2+a)+e+x -> edx:eax=(a+b*c+2/c)/(2+a)+e+x
        mov edx, 0
        add eax, ebx
        adc edx, ecx
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
