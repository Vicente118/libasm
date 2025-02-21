;; char *strdup(const char *s);

bits 64

extern malloc
extern ft__strlen
extern ft__strcpy
global ft__strdup

ft__strdup:
    push    rdi             ;; Save s on rdi
    call    ft__strlen      ;; ft__strlen(s)
    inc     rax             ;; add the '\0' to the length
    mov     rdi, rax
    call    malloc
    cmp     rax, 0
    je      error
    mov     rdi, rax
    pop     rsi
    call    ft__strcpy
    ret
    
error:
    mov     rax, 0
    ret