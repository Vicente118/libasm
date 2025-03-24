bits 64

global ft__list__sort

ft__list__sort:
    push    rbp
    mov     rbp, rsp
    
    mov     rax, qword [rdi]     ;; *lst in rax
    test    rax, rax
    jz      return

loop:
    cmp qword [rax + 8], 0

return:
    leave
    ret