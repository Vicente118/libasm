;; char *strcpy(char *destination, const char *source);

bits 64

global ft__strcpy

ft__strcpy:
    push    rbp
    mov     rbp, rsp
    mov     rcx, 0

loop:
    mov     al, byte [rsi + rcx]
    mov     [rdi + rcx], al 
    cmp     al, 0
    je      exit
    inc     rcx
    jmp     loop

exit:
    mov     rax, rdi
    leave
    ret