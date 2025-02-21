;; size_t strlen(const char *s);

bits 64

global ft__strlen

ft__strlen:
    mov     rax, 0

loop:
    cmp     BYTE [rdi + rax], 0
    je      exit
    inc     rax
    jmp     loop
exit:
    ret