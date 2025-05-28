bits 64

extern __errno_location
global ft_write

ft_write:
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
    mov     r9, rax           ;; Save errno from rax in temporary register
    call    __errno_location wrt ..plt ;; This put the address of errno in rax
    mov     [rax], r9         ;; putting the errno value from r9 at the address of rax
    mov     rax, -1           ;; Return value = -1
    leave
    ret