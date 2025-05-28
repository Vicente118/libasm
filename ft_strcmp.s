;; int     ft__strcmp(const char *s1, const char *s2);

bits 64

global ft_strcmp

ft_strcmp:
    push    rbp
    mov     rbp, rsp
    mov     rcx, 0

loop:
    mov     al, byte [rdi + rcx]
    mov     ah, byte [rsi + rcx]
    cmp     al, ah
    jne     diff
    cmp     al, 0
    je      exit
    inc     rcx
    jmp     loop

diff:
    sub     al, ah
    movsx   rax, al
    leave
    ret
exit:
    mov     rax, 0
    leave
    ret