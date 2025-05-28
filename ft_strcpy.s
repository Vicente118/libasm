;; char *strcpy(char *destination, const char *source);

bits 64

global ft_strcpy

ft_strcpy:
    push    rbp
    mov     rbp, rsp                    ;; Init stack frame
    push    rcx
    mov     rcx, 0                      ;; Mov 0 into rcx

loop:
    mov     al, byte [rsi + rcx]        ;; Mov *(src + rcx) into al (Because al register is 1 byte)
    mov     byte [rdi + rcx], al        ;; Then mov al value into *(dest + rcx)
    cmp     al, 0                       ;; Compare al with 0
    je      exit                        ;; Jump to exit label if al == 0
    inc     rcx                         ;; rcx += 1
    jmp     loop                        

exit:
    mov     rax, rdi                    ;; mov rdi into rax (Rax is the return value)
    pop     rcx
    leave
    ret