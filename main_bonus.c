# include <stdio.h>
# include <unistd.h>
# include <string.h>
# include <stdlib.h>
# include "colors.h"

typedef struct s_list
{
    void            *content;
    struct s_list   *next;
}                   t_list;

char    *ft_strdup(const char *s);
int     ft_strcmp(const char *s1, const char *s2);
void    print_list(t_list *list);
void    free_fct(void *data);

int     ft_list_size(t_list *begin_list);
void    ft_list_push_front(t_list **begin_list, void *data);
void    ft_list_sort(t_list **begin_list, int (*cmp)());
void    ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *));

int main()
{
    t_list *node_1 = malloc(sizeof(t_list));
    t_list *node_2 = malloc(sizeof(t_list));
    t_list *node_3 = malloc(sizeof(t_list));

    node_1->content = ft_strdup("G");
    node_1->next = node_2;

    node_2->content = ft_strdup("L");
    node_2->next = node_3;

    node_3->content = ft_strdup("A");
    node_3->next = NULL;

    t_list  *ptr_to_node_1 = node_1;

    /// LIST SIZE ///
    printf(BGREEN "###  ft_list_size()  ###\n" RESET);
    int list_size       = ft_list_size(node_1);
    int empty_list_size = ft_list_size(NULL);

    printf("Size of the list = %d\n", list_size);
    printf("Size of the list = %d\n\n\n", empty_list_size);

    /// LIST PUSH FRONT ///
    printf(BGREEN "###  ft_list_push_front()  ###\n" RESET);
    char    *data       = ft_strdup("Z");

    ft_list_push_front(&ptr_to_node_1, data); 
    printf("Size of the list = %d\n", ft_list_size(ptr_to_node_1));
    print_list(ptr_to_node_1);
    printf("\n\n");

    /// SORT LIST ////
    printf(BGREEN "###  ft_list_sort()  ###\n" RESET);
    int (*cmp)() = &ft_strcmp;
    
    ft_list_sort(&ptr_to_node_1, cmp);
    print_list(ptr_to_node_1);
    printf("\n\n");

    ////////////////
    /// ATOI BASE ///

    return 0;
}

void    print_list(t_list *list)
{
    t_list *tmp = list;

    int i = 0;

    while (tmp != NULL)
    {
        printf("Node %d: %s\n", i, (char *)tmp->content);

        tmp = tmp->next;
        i++;
    }
}

void    free_fct(void *data)
{
	free(data);
}