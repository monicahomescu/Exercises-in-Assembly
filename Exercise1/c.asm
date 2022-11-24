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
    c dd 5h
    d dq 3h
    x resd 1
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        ;(c+b)-a-(d+d)
        
        ;storing c in cx:bx -> cx:bx=c
        mov bx, word[c]
        mov cx, word[c+2]
        
        ;converting b into dd -> dx:ax=b
        mov ax, [b]
        cwd
        
        ;calculating (c+b) -> cx:bx=(c+b)
        add bx, ax
        adc cx, dx
        
        ;converting a into dd -> dx:ax=a
        mov al, [a]
        cbw
        cwd
        
        ;calculating (c+b)-a -> cx:bx=(c+b)-a
        sub bx, ax
        sbb cx, dx
        
        ;saving the result
        mov [x+0], bx
        mov [x+2], cx
        
        ;storing d in ecx:ebx -> ecx:ebx=d
        mov ebx, dword[d]
        mov ecx, dword[d+4]
        
        ;storing d in edx:eax -> edx:eax=d
        mov eax, dword[d]
        mov edx, dword[d+4]
        
        ;calculating (d+d) -> ecx:ebx=(d+d)
        add ebx, eax
        adc ecx, edx
        
        ;storing (c+b)-a in dx:ax -> dx:ax=(c+b)-a
        mov ax, [x+0]
        mov dx, [x+2]
        
        ;saving (c+b)-a in eax -> eax=(c+b)-a
        push dx
        push ax
        pop eax
        
        ;calculating (c+b)-a-(d+d) -> edx:eax=(c+b)-a-(d+d)
        mov edx, 0
        sub eax, ebx
        sbb edx, ecx
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
