bits 64

global ft__list__size

ft__list__size:
    xor     rax, rax
    cmp     rdi, 0
    jz      null
    inc     rax
loop:
    cmp     qword [rdi + 8], 0
    jz      return
    inc     rax
    mov     rdi, qword [rdi + 8]
    jmp     loop

return:
    ret

null:
    mov     rax, 0
    ret