;; int     ft__strcmp(const char *s1, const char *s2);

bits 64

global ft__strcmp

ft__strcmp:
    mov     rcx, 0

loop:
    mov     al, BYTE [rdi + rcx]
    mov     ah, BYTE [rsi + rcx]
    cmp     al, ah
    jne     diff
    cmp     al, 0
    je      exit
    inc     rcx
    jmp     loop

diff:
    sub     al, ah
    movsx   rax, al
    ret
exit:
    mov     rax, 0
    ret