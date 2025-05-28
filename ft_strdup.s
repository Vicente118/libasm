;; char *strdup(const char *s);

bits 64

extern malloc
extern ft_strlen
extern ft_strcpy
global ft_strdup

ft_strdup:
    push    rbp
    mov     rbp, rsp
    push    rbx             ;; Sauvegarde rbx (callee-saved)
    sub     rsp, 8
    
    mov     rbx, rdi        ;; Sauvegarde s dans rbx
    call    ft_strlen       
    inc     rax             
    mov     rdi, rax
    call    malloc
    test    rax, rax
    je      error
    
    mov     rdi, rax        ;; Destination pour strcpy
    mov     rsi, rbx        ;; Source (string originale) depuis rbx
    call    ft_strcpy

    add     rsp, 8
    pop     rbx             ;; Restaure rbx
    leave
    ret
    
error:
    mov     rax, 0          ;; NULL en cas d'erreur
    add     rsp, 8
    pop     rbx             ;; Restaure rbx
    leave
    ret