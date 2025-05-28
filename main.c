# include <stdio.h>
# include <string.h>
# include <unistd.h>
# include <stdlib.h>
# include <sys/types.h>
# include <errno.h>
# include "colors.h"

ssize_t ft_write(int fd, const void *buf, size_t count);
ssize_t ft_read(int fd, void *buf, size_t count);
int     ft_strlen(const char *str);
int     ft_strcmp(const char *s1, const char *s2);
char    *ft_strcpy(const char *source, const char *destination);
char    *ft_strdup(const char *s);

int main()
{
    printf(BGREEN "###  ft_strlen()  ###\n" RESET);
    printf("ft_strlen(\"\")              = %d\n",   ft_strlen(""));
    printf("ft_strlen(\"Hello world !\") = %d\n\n\n", ft_strlen("Hello world !"));

//////////////////////////////////////////////////////////////////////////////////////////////////
    printf(BGREEN "###  ft_strcpy()  ###\n" RESET);

    char    *source = "Hello world !";
    char    *destination = malloc(sizeof(char) * strlen(source) + 1);

    printf("ft_strcpy(destination, source) = %s\n\n\n", ft_strcpy(destination, source));
    free(destination);

//////////////////////////////////////////////////////////////////////////////////////////////////
    printf(BGREEN "###  ft_strcmp()  ###\n" RESET);
    char    *s1 = "Certainement";
    char    *s2 = "Certitude";
    char    *s3 = "";

    printf("ft_strcmp(s1, s2) = %d\n",   ft_strcmp(s1, s2));
    printf("ft_strcmp(s1, s3) = %d\n",   ft_strcmp(s1, s3));
    printf("ft_strcmp(s1, s1) = %d\n\n\n", ft_strcmp(s1, s1));

//////////////////////////////////////////////////////////////////////////////////////////////////
    printf(BGREEN "###  ft_write()  ###\n" RESET);
    fflush(stdout);
    ssize_t res = ft_write(1, "ft_write() is writing on stdout !\n\n", 36);

    if (res == -1)
    {
        perror("Error");
    }

    res = ft_write(-1, "ft_write() is writing on stdout !\n", 35);

    if (res == -1)
    {
        perror("Error");
    }

    printf("\n\n");

//////////////////////////////////////////////////////////////////////////////////////////////////
    printf(BGREEN "###  ft_read()  ###\n" RESET);
    fflush(stdout);
    char *buffer = malloc(1024);
    memset(buffer, 0, 1024);

    ft_write(1, "Program waits for an input: ", 29);

    res = ft_read(1, buffer, 1024);

    if (res == -1)
    {
        perror("Error");
    }

    printf("%s\n", buffer);

    res = ft_read(-1, buffer, 1024);

    if (res == -1)
    {
        perror("Error");
    }

    printf("\n\n");
    free(buffer);

//////////////////////////////////////////////////////////////////////////////////////////////////
    printf(BGREEN "###  ft_strdup()  ###\n" RESET);
    char *dup = ft_strdup("New string from ft_strdup !");

    printf("%s\n", dup);
    free(dup);

    return 0;
}
