bits 64

extern __errno_location
global ft__write

ft__write:
    push    rbp                 ;; Init stack frame
    mov     rbp, rsp
    mov     rax, 1              ;; Put 1 into rax
    syscall                     ;; call write
    test    rax, rax
    js      error               ;; jump to error label if rax < 0
    leave
    ret

error:
    neg     rax               ;; Errno value negative to positive
    push    rax               ;; Save errno value on the stack
    call    __errno_location wrt ..plt ;; This put the address of errno in rax
    pop     qword [rax]       ;; Pop the errno value off the stack and putting the value into the address of errno
    mov     rax, -1           ;; Return value = -1
    leave
    ret