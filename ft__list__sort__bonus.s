bits 64

global ft__list__sort

ft__list__sort:
    push    rbp
    mov     rbp, rsp
    
    mov     r12, rdi          ;; put list in r12
    mov     rbx, qword [rdi]  ;; put *list in rbx
    mov     rbp, rsi          ;; put cmp pointer in rbp

    test    r12, r12  ;; Check NULL for list
    jz      return  
    test    rbx, rbx  ;; Check NULL for *list
    jz      return
    test    rbp, rbp  ;; Check NULL for cmp()  
    jz      return

    mov     rax, qword [rbx + 8] ;; Put current->next in rax then check for NULL
    test    rax, rax
    jnz     loop                 ;; If not NULL jump to loop, Else just return

return:
    leave
    ret

next_node:
    mov     rbx, qword [rbx + 8]
check_null:
    mov     rax, qword [rbx + 8]   ;; Put current->next in rax then check for NULL
    test    rax, rax
    jz      return                 ;; If not NULL jump to loop, Else just return

loop:
    mov     rdi, qword [rbx]       ;; put current->data in rdi (first param)
    mov     rsi, qword [rax]       ;; put current->next->data in rsi (second param)
    xor     eax, eax
    call    rbp

    cmp     eax, 0
    jle     next_node              ;; jump if less or equal

    mov     rdx, qword [rbx]       ;; temp = current->data

    mov     rax, qword [rbx + 8]   ;; current->next into rax
    mov     rcx, qword [rax]       ;; current->next->data into rcx 
    mov     qword [rbx], rcx       ;; current->next->data into current->data

    mov     rbx, qword [r12]       ;; current = *begin_list;

    jmp     check_null




;; t_list *current = *lst;