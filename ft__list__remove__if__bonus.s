bits 64

global ft__list__remove__if

ft__list__remove__if:
    push    rbp
    mov     rbp, rsp

    push    r12
    push    rbx
    push    r13
    push    r11
    push    r14
    push    r15                 ;; Save to stock first prev node

    mov     r12, rdi            ;; Save list in r12
    mov     rbx, qword [rdi]    ;; Save *list in rbx
    mov     r13, rsi            ;; Save data_ref in r13
    mov     r11, rdx            ;; Save cmp ptr in r11
    mov     r14, rcx            ;; Save free_fct ptr in r14

    test    r12, r12
    jz      return
    test    rbx, rbx
    jz      return
    test    r13, r13
    jz      return
    test    r11, r11
    jz      return
    test    r14, r14
    jz      return

check_first_node:
    mov     rdi, qword [rbx]
    mov     rsi, r13
    call    r11
    cmp     rax, 0
    je      remove_first_node

    mov     r15, rbx            ;; r15 = prev = current
    mov     rbx, qword [rbx + 8];; rbx = current->next
    test    rbx, rbx
    jz      return              ;; Si fin de liste, terminer
    ; jmp     loop                ;; Sinon, commencer la boucle principale

;;Remove first node until strcmp != 0 then jump to main loop
remove_first_node:
    mov     rdi, qword [rbx]    ;; current->content
    call    r14                 ;; free_fct(current->content)

    mov     rax, qword [rbx + 8];; rax = current->next
    mov     qword [r12], rax    ;; *begin_list = current->next

    mov     rbx, rax            ;; rbx = nouveau current
    test    rbx, rbx
    jz      return              ;; Si liste vide après suppression, terminer
    
    jmp     check_first_node         ;; Vérifier à nouveau le premier élément

return:
    pop     r15
    pop     r14
    pop     r11
    pop     r13
    pop     rbx
    pop     r12

    leave
    ret

free:
    mov     rdi, qword [rbx]
    call    r14

next_node:
    mov     rbx, qword [rbx + 8]

check_null:
    mov     rax, qword [rbx + 8]
    test    rax, rax
    jz      return

; loop:


; remove_node:
    