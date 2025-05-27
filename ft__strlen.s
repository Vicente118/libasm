;; size_t strlen(const char *s);

bits 64

global ft__strlen

ft__strlen:
    push    rbp                         ;; Init stack frame
    mov     rbp, rsp
    xor     rax, rax                    ;; Put rax to 0

loop:
    cmp     byte [rdi + rax], 0         ;; Compare *(s + i) and 0
    je      exit                        ;; if *(s + i) == 0 -> jump to exit label
    inc     rax                         ;; Increment i
    jmp     loop                        ;; jump to loop label
exit:
    leave                               ;; End of the stack frame
    ret                                 ;; return i (rax)