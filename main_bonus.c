# include <stdio.h>
# include <unistd.h>
# include <string.h>
# include <stdlib.h>

typedef struct s_list
{
    void            *content;
    struct s_list   *next;
}                   t_list;

int     ft_strcmp(const char *s1, const char *s2);
void    print_list(t_list *list);

int     ft__list__size(t_list *begin_list);
void    ft__list__push__front(t_list **begin_list, void *data);
void    ft__list__sort(t_list **begin_list, int (*cmp)());

int main()
{
    t_list      node_1;
    t_list      node_2;
    t_list      node_3;

    node_1.content = (char *)strdup("Content 1");
    node_1.next    = &node_2;

    node_2.content = (char *)strdup("Content 2");
    node_2.next    = &node_3;

    node_3.content = (char *)strdup("Content 3");
    node_3.next    = NULL;

    //// LIST SIZE ////
    int list_size       = ft__list__size(&node_1);
    int empty_list_size = ft__list__size(NULL);

    printf("Size of the list = %d\n", list_size);
    printf("Size of the list = %d\n", empty_list_size);

    //// LIST PUSH FRONT ////
    t_list  *ptr_to_node_1 = &node_1;
    char    *content       = strdup("Content 0");

    ft__list__push__front(&ptr_to_node_1, content); 
    printf("Size of the list = %d\n", ft__list__size(ptr_to_node_1));
    printf("%s\n", (char *)ptr_to_node_1->content);

    //// SORT LIST ////
    int (*cmp)() = &ft_strcmp;
    
    // print_list(ptr_to_node_1);
    // ft__list__sort(&ptr_to_node_1, cmp);
    // print_list(ptr_to_node_1);


    //// FREE ////
    free(content);

    return 0;
}

int     ft_strcmp(const char *s1, const char *s2)
{
    int i = 0;

    while (s1[i] && s1[i] == s2[i])
    {
        i++;
    }
    return (int)(s1[i] - s2[i]);
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