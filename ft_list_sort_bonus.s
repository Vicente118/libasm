bits 64

global ft_list_sort

ft_list_sort:
    push    rbp
    mov     rbp, rsp
    
    push    rbx                    ;; Sauvegarde des registres callee-saved
    push    r12
    push    r13
    push    r14                    
    push    r15                    ;; Ajouter r15 pour sauvegarder temporairement
    sub     rsp, 8

    test    rdi, rdi               ;; Check NULL for list
    jz      return
    mov     r12, rdi               ;; r12 = begin_list
    
    test    rsi, rsi               ;; Check NULL for cmp
    jz      return
    mov     r13, rsi               ;; r13 = cmp

check_first:
    mov     rbx, [r12]             ;; rbx = *begin_list (current)
    test    rbx, rbx               
    jz      return                 ;; Si la liste est vide, sortir
    
outer_loop:
    mov     r14, rbx               ;; r14 = current
    
inner_loop:
    mov     r15, [r14 + 8]         ;; r15 = current->next
    test    r15, r15
    jz      advance_outer          ;; Si next est NULL, avancer dans la boucle externe
    
    mov     rdi, [r14]             ;; rdi = current->content
    mov     rsi, [r15]             ;; rsi = next->content
    
    push    rbx                    ;; IMPORTANT: Préserver tous les registres
    push    r12                    ;; qui peuvent être modifiés par l'appel
    push    r14
    push    r15
    
    call    r13                    ;; Appeler cmp
    
    pop     r15                    ;; IMPORTANT: Restaurer les registres
    pop     r14
    pop     r12
    pop     rbx
    
    test    eax, eax
    jle     next_inner             ;; Si <= 0, pas besoin de swap
    
    mov     rdi, [r14]             ;; tmp = current->content
    mov     rsi, [r15]             ;; rsi = next->content
    mov     [r14], rsi             ;; current->content = next->content
    mov     [r15], rdi             ;; next->content = tmp
    
next_inner:
    mov     r14, r15               ;; current = next
    jmp     inner_loop             ;; Continuer boucle interne
    
advance_outer:
    mov     rbx, [rbx + 8]         ;; current = current->next
    test    rbx, rbx
    jz      return                 ;; Si NULL, fin du tri
    jmp     outer_loop             ;; Sinon, continuer boucle externe

return:
    add     rsp, 8
    pop     r15
    pop     r14
    pop     r13
    pop     r12
    pop     rbx
    leave
    ret