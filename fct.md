# Fonction `ft_list_remove_if` : Analyse et Plan d'implémentation

## Analyse de la fonction

`void ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *));`

Cette fonction parcourt une liste chaînée et supprime tous les éléments dont le contenu correspond à une référence donnée selon une fonction de comparaison.

### Paramètres
1. `t_list **begin_list` : Pointeur vers le pointeur du début de la liste (permet de modifier la tête de liste)
2. `void *data_ref` : Données de référence pour la comparaison
3. `int (*cmp)()` : Fonction de comparaison qui renvoie 0 si les données correspondent
4. `void (*free_fct)(void *)` : Fonction pour libérer le contenu des nœuds supprimés

### Comportement
- Si un nœud a un contenu qui correspond à `data_ref` selon `cmp()`, il doit être supprimé
- La mémoire du contenu doit être libérée avec `free_fct`
- La mémoire du nœud lui-même doit être libérée avec `free`
- Les liens de la liste doivent être reconstruits pour maintenir la structure
- Si le premier nœud correspond, la tête de liste doit être mise à jour

## Plan d'implémentation en assembleur

1. **Prologue de fonction**
   - Sauvegarde des registres selon la convention d'appel
   - Notamment préserver les registres callee-saved (rbx, r12-r15)

2. **Vérification des cas NULL**
   - Vérifier si `begin_list` est NULL (retourner immédiatement)
   - Vérifier si `*begin_list` est NULL (retourner immédiatement)
   - Vérifier si `cmp` ou `free_fct` est NULL (retourner immédiatement)

3. **Gestion du premier nœud (cas spécial)**
   - Sauvegarder `*begin_list` dans un registre temporaire 
   - Appeler `cmp((*begin_list)->content, data_ref)`
   - Si le résultat est 0 (correspondance) :
     - Sauvegarder le pointeur vers le nœud suivant
     - Appeler `free_fct((*begin_list)->content)`
     - Libérer le nœud actuel avec `free`
     - Mettre à jour `*begin_list` avec le pointeur suivant
     - Recommencer depuis l'étape 3 (récursion ou boucle)

4. **Parcourir le reste de la liste**
   - Utiliser deux pointeurs : `current` et `previous`
   - Parcourir la liste avec `current` en partant du deuxième nœud
   - Pour chaque nœud :
     - Appeler `cmp(current->content, data_ref)`
     - Si correspondance :
       - Faire pointer `previous->next` vers `current->next`
       - Appeler `free_fct(current->content)`
       - Sauvegarder le pointeur suivant
       - Libérer `current` avec `free`
       - Mettre à jour `current` avec le pointeur sauvegardé
     - Sinon :
       - Mettre à jour `previous = current`
       - Mettre à jour `current = current->next`

5. **Épilogue de fonction**
   - Restaurer les registres sauvegardés
   - Retourner

## Code détaillé pour implementation 

En assembleur x86-64, les registres pourraient être utilisés comme suit :
- `r12` pour stocker `begin_list`
- `r13` pour stocker `data_ref`
- `r14` pour stocker `cmp`
- `r15` pour stocker `free_fct`
- `rbx` pour le nœud courant
- `rcx` pour le nœud précédent

L'algorithme devra gérer attentivement les cas particuliers comme :
- Suppression du premier nœud
- Suppression de nœuds consécutifs
- Suppression du dernier nœud

Une attention particulière doit être accordée à la gestion des appels de fonctions externes (`cmp`, `free_fct`, `free`) car ils peuvent modifier certains registres selon la convention d'appel.