;; size_t strlen(const char *s);

bits 64

global ft__strlen

ft__strlen:
    xor     rax, rax

loop:
    cmp     byte [rdi + rax], 0
    je      exit
    inc     rax
    jmp     loop
exit:
    ret