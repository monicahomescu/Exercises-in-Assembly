bits 32

global start

extern exit, fopen, fprintf, fclose, scanf, printf
import exit msvcrt.dll
import fopen msvcrt.dll
import fprintf msvcrt.dll
import fclose msvcrt.dll
import scanf msvcrt.dll
import printf msvcrt.dll 

segment data use32 class=data

    file_name db "file.txt", 0    ;filename to be created
    access_mode db "w", 0    ;file access mode: w - creates an empty file for writing
    file_descriptor dd -1    ;variable to hold the file descriptor
    n dd 0    ;variable to store the value read from the keyboard
    format db "%d", 0    ;%d <=> a decimal number (base 10)
    space db " ", 0    ;empty space to add between values
    
segment code use32 class=code
    start:
    
        ;A file name is given (defined in the data segment). Create a file with the given name, then read numbers from the keyboard and write only the numbers divisible by 7 to file, until the value '0' is read from the keyboard.
    
        ;call fopen() to create the file
        ;fopen() will return a file descriptor in EAX or 0 in case of error
        ;eax = fopen(file_name, access_mode)
        push dword access_mode     
        push dword file_name
        call [fopen]
        add esp, 4 * 2    ;clean-up the stack
        
        mov [file_descriptor], eax    ;store the file descriptor returned by fopen
        
        cmp eax, 0    ;check if fopen() has successfully created the file (EAX != 0)
        je final    ;jump to final if EAX = 0
        
        repeta:
        
            ;call scanf(format, n) => read a number in variable n
            ;place parameters on stack
            push dword n    ;! address of n, not value
            push dword format
            call [scanf]    ;call function scanf for reading
            add esp, 4 * 2    ;clean-up the stack
            
            cmp dword[n], 0    ;compare the value of n with 0
            je opreste    ;jump to opreste if n = 0
            
            mov ax, word[n]    ;store the doubleword n
            mov dx, word[n+2]
            mov si, 7h   
            div si    ;divide n by 7
            cmp dx, 0    ;check the remainder
            jne sari    ;jump to sari if the remainder is not 0
            
            ;write n in file using fprintf()
            ;fprintf(file_descriptor, n)
            push dword [n]
            push dword format
            push dword [file_descriptor]
            call [fprintf]
            add esp, 4 * 2    ;clean-up the stack
            
            ;write space in file using fprintf()
            ;fprintf(file_descriptor, space)
            push dword space
            push dword [file_descriptor]
            call [fprintf]
            add esp, 4 * 2    ;clean-up the stack
            
            sari:
            
        jmp repeta
        
        opreste:
          
        ;call fclose() to close the file
        ;fclose(file_descriptor)
        push dword [file_descriptor]
        call [fclose]
        add esp, 4    ;clean-up the stack

      final:

        push dword 0      
        call [exit]