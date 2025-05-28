bits 64

extern malloc

global ft_list_push_front

ft_list_push_front:
    push    rbp
    mov     rbp, rsp

    mov     rbx, rdi              ;; Save rdi (lst)

    test    rdi, rdi              ;; Check if rdi is NULL
    je      return  
    
    push    rsi                   ;; Save rsi because malloc erase it for some reason
    sub     rsp, 8

    mov     rdi, 16               ;; To allocate 16 bytes with malloc
    call    malloc
    test    rax, rax              ;; Check if malloc failed
    je      return

    add     rsp, 8
    pop     qword [rax]           ;; new->content = data;
    mov     rdx, qword [rbx]      ;; save *lst in rdx
    mov     qword [rax + 8], rdx  ;; new->next = *lst
    mov     qword [rbx], rax      ;; *lst = new

return:
    leave
    ret


; TODO :

; - Check if **lst is NULL
; - Malloc a new t_list and save it's address
; - Make the new t_list point to the first element of lst
; - Assign the new t_list to *lst