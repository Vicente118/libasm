# include <stdio.h>
# include <unistd.h>
# include <string.h>
# include <stdlib.h>

typedef struct s_list
{
    void            *content;
    struct s_list   *next;
}                   t_list;

char    *ft__strdup(const char *s);
int     ft__strcmp(const char *s1, const char *s2);
void    print_list(t_list *list);
void    free_fct(void *data);

int     ft__list__size(t_list *begin_list);
void    ft__list__push__front(t_list **begin_list, void *data);
void    ft__list__sort(t_list **begin_list, int (*cmp)());
void    ft__list__remove__if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *));

int main()
{
    t_list      node_1;
    t_list      node_2;
    t_list      node_3;

    node_1.content = (char *)ft__strdup("A");
    node_1.next    = &node_2;

    node_2.content = (char *)ft__strdup("A");
    node_2.next    = &node_3;

    node_3.content = (char *)ft__strdup("A");
    node_3.next    = NULL;

    //// LIST SIZE ////
    int list_size       = ft__list__size(&node_1);
    int empty_list_size = ft__list__size(NULL);

    printf("Size of the list = %d\n", list_size);
    printf("Size of the list = %d\n", empty_list_size);

    //// LIST PUSH FRONT ////
    t_list  *ptr_to_node_1 = &node_1;
    char    *data       = ft__strdup("A");

    ft__list__push__front(&ptr_to_node_1, data); 
    printf("Size of the list = %d\n", ft__list__size(ptr_to_node_1));
    printf("\n");

    //// SORT LIST ////
    int (*cmp)() = &ft__strcmp;
    
    print_list(ptr_to_node_1);
    printf("\n");
    ft__list__sort(&ptr_to_node_1, cmp);
    print_list(ptr_to_node_1);


    //// REMOVE IF ////
    char    *compared = "A";
    char    *compared_2 = "R";

    printf("\n");
    ft__list__remove__if(&ptr_to_node_1, compared, &ft__strcmp, &free_fct);
    print_list(ptr_to_node_1);

    //// FREE ////
    free(data);

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