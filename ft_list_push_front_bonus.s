bits 64

extern malloc

global ft_list_push_front

ft_list_push_front:
    push    rbp
    mov     rbp, rsp
    
    push    rbx                ;; sauvegarde de rbx
    
    mov     rbx, rdi           ;; Save rdi (lst)

    test    rdi, rdi           ;; Check if rdi is NULL
    je      return  
    
    push    rsi                ;; Save rsi because malloc erase it for some reason
    sub     rsp, 8

    mov     rdi, 16            ;; To allocate 16 bytes with malloc
    call    malloc
    test    rax, rax           ;; Check if malloc failed
    je      restore_and_return

    add     rsp, 8
    pop     qword [rax]        ;; new->content = data;
    mov     rdx, qword [rbx]   ;; save *lst in rdx
    mov     qword [rax + 8], rdx ;; new->next = *lst
    mov     qword [rbx], rax   ;; *lst = new

return:
    pop     rbx                ;; restauration de rbx
    leave
    ret

restore_and_return:
    add     rsp, 8             ;; Si malloc a échoué, ajuster la pile
    pop     rsi                ;; et restaurer rsi
    jmp     return