bits 32

global start        

extern exit, scanf, printf               
import exit msvcrt.dll
import scanf msvcrt.dll
import printf msvcrt.dll 
               
segment data use32 class=data
   
    a dw 0    ;variable to store the value of a read from the keyboard
    b dw 0    ;variable to store the value of b read from the keyboard
    message1 db "a=", 0    ;message to display for reading variable a
    message2 db "b=", 0    ;message to display for reading variable b
    format db "%d", 0    ;%d <=> a deciaml number (base 10)
    result resd 1    ;variabile to store the result

segment code use32 class=code
    start:
    
        ;Read two numbers a and b (in base 10) from the keyboard and calculate their product. This value will be stored in a variable called "result" (defined in the data segment).
        
        ;call printf(message1) => print "a="
        ;place parameters on stack
        push dword message1    ;! address of string, not value
        call [printf]    ;call function printf for printing
        add esp, 4    ;free parameters on the stack
        
        ;call scanf(format, a) => read a number in variable a
        ;place parameters on stack
        push dword a    ;! address of a, not value
        push dword format
        call [scanf]    ;call function scanf for reading
        add esp, 4 * 2    ;free parameters on the stack
        
        ;call printf(message2) => print "b="
        ;place parameters on stack
        push dword message2    ;! address of string, not value
        call [printf]    ;call function printf for printing
        add esp, 4    ;free parameters on the stack
        
        ;call scanf(format, b) => read a number in variable b
        ;place parameters on stack
        push dword b    ;! address of b, not value
        push dword format
        call [scanf]    ;call function scanf for reading
        add esp, 4 * 2    ;free parameters on the stack
        
        mov ax, [a]
        mov dx, [b]
        mul dx    ;multiply a and b
        
        mov [result], eax    ;store the value in result
        
        ;call printf(format, result) => print: "result"
        ;place parameters on the stack
        push dword [result]   ;! address of string, not value
        push dword format
        call [printf]    ;call function printf for printing 
        add esp, 4 * 2    ;free parameters on the stack
        
        push    dword 0      
        call    [exit]      
