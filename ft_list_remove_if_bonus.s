bits 64

global ft_list_remove_if
extern free
ft_list_remove_if:
    push    rbp
    mov     rbp, rsp

    push    rbx         ;; Current node
    push    r12         ;; begin_list
    push    r13         ;; data_ref
    push    r14         ;; cmp function
    push    r15         ;; free_fct
    sub     rsp, 8      ;; Align stack

    ;; Sauvegarde des arguments
    mov     r12, rdi
    mov     r13, rsi
    mov     r14, rdx
    mov     r15, rcx
    
    ;; Vérifications des pointeurs nuls
    test    r12, r12
    jz      exit
    test    r14, r14
    jz      exit
    test    r15, r15
    jz      exit
    
check_first:
    ;; Récupérer le premier élément
    mov     rbx, [r12]
    test    rbx, rbx
    jz      exit        ;; Si liste vide, sortir

    ;; Comparer le premier élément
    mov     rdi, [rbx]  ;; rdi = current->content
    mov     rsi, r13    ;; rsi = data_ref
    call    r14         ;; Appel de cmp()
    
    test    eax, eax
    jnz     next_elements ;; Si pas égal, passer au reste de la liste
    
    ;; Si égal, supprimer le premier élément
    mov     rax, [rbx + 8]      ;; rax = current->next
    
    ;; Libérer le contenu
    mov     rdi, [rbx]          ;; rdi = current->content
    call    r15                 ;; free_fct(content)
    
    ;; Mise à jour de l'en-tête
    mov     rax, [rbx + 8]      ;; Recharger next (pourrait être modifié par call)
    mov     [r12], rax          ;; *begin_list = next
    
    ;; NOUVEAU: Libérer le nœud lui-même
    mov     rdi, rbx            ;; Préparer le nœud à libérer
    call    free                ;; Libérer le nœud
    
    ;; Continuer avec le nouveau premier nœud
    jmp     check_first         ;; Vérifier à nouveau l'élément de tête

next_elements:
    ;; À ce point, le premier élément ne correspond pas au critère
    mov     rcx, rbx            ;; rcx = prev = current
    mov     rbx, [rbx + 8]      ;; rbx = current = current->next
    test    rbx, rbx
    jz      exit                ;; Si NULL, fin de la liste

process_loop:
    ;; Comparer l'élément courant
    mov     rdi, [rbx]          ;; rdi = current->content
    mov     rsi, r13            ;; rsi = data_ref
    call    r14                 ;; Appel de cmp()
    
    test    eax, eax
    jnz     advance             ;; Si pas égal, avancer
    
    ;; Si égal, supprimer l'élément
    mov     rax, [rbx + 8]      ;; Sauvegarder next avant l'appel
    
    mov     rdi, [rbx]          ;; rdi = current->content
    call    r15                 ;; free_fct(content)
    
    ;; Mettre à jour les pointeurs
    mov     [rcx + 8], rax      ;; prev->next = current->next
    
    ;; NOUVEAU: Libérer le nœud lui-même
    mov     rdi, rbx            ;; Préparer le nœud à libérer
    mov     rbx, rax            ;; current = next (AVANT de libérer current)
    call    free                ;; Libérer le nœud
    
    ;; Vérifier si on est à la fin
    test    rbx, rbx
    jz      exit                ;; Si NULL, fin de la liste
    jmp     process_loop        ;; Sinon, continuer le traitement
    
advance:
    ;; Avancer dans la liste
    mov     rcx, rbx            ;; prev = current
    mov     rbx, [rbx + 8]      ;; current = current->next
    test    rbx, rbx
    jz      exit                ;; Si NULL, fin de la liste
    jmp     process_loop        ;; Sinon, continuer le traitement

exit:
    add     rsp, 8
    pop     r15
    pop     r14
    pop     r13
    pop     r12
    pop     rbx
    leave
    ret