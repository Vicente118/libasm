bits 64

global ft__list__size

ft__list__size:
    push    rbp
    mov     rbp, rsp
    xor     rax, rax   ; [rax] = 0
    cmp     rdi, 0     ; compare rdi value and 0/NULL
    jz      null       ; jump to null label if rdi == 0
    inc     rax        ; [rax]++
loop:
    cmp     qword [rdi + 8], 0    ; compare 
    jz      return
    inc     rax
    mov     rdi, qword [rdi + 8]
    jmp     loop

return:
    leave
    ret

null:
    mov     rax, 0
    leave
    ret