bits 64

extern __errno_location
global ft_read

ft_read:
    push    rbp
    mov     rbp, rsp

    mov     rax, 0
    syscall
    test    rax, rax
    js      error
    leave
    ret

error:
    neg     rax               ;; Errno value negative to positive
    push    rax               ;; Save errno value on the stack
    call    __errno_location wrt ..plt  ;; This put the address of errno in rax
    pop     qword [rax]       ;; Pop the errno value off the stack and putting the value into the address of errno
    mov     rax, -1           ;; Return value = -1
    leave
    ret