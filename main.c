#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/types.h>
#include <errno.h>


ssize_t ft__write(int fd, const void *buf, size_t count);
ssize_t ft__read(int fd, void *buf, size_t count);
int     ft__strlen(const char *str);
int     ft__strcmp(const char *s1, const char *s2);
char    *ft__strcpy(const char *source, const char *destination);
char    *ft__strdup(const char *s);

int main()
{
    printf("ft__strlen(\"\")              = %d\n", ft__strlen(""));
    printf("ft__strlen(\"Hello world !\") = %d\n\n", ft__strlen("Hello world !"));

//////////////////////////////////////////////////////////////////////////////////////////////////
   
    char    *source = "Hello world !";
    char    *destination = malloc(sizeof(char) * strlen(source) + 1);

    printf("ft__strcpy(destination, source) = %s\n\n", ft__strcpy(destination, source));
    free(destination);

//////////////////////////////////////////////////////////////////////////////////////////////////
   
    char    *s1 = "Certainement";
    char    *s2 = "Certitude";
    char    *s3 = "";

    printf("ft__strcmp(s1, s2) = %d\n", ft__strcmp(s1, s2));
    printf("ft__strcmp(s1, s3) = %d\n", ft__strcmp(s1, s3));
    printf("ft__strcmp(s1, s1) = %d\n\n", ft__strcmp(s1, s1));

//////////////////////////////////////////////////////////////////////////////////////////////////

    ssize_t res = ft__write(1, "ft__write() is writing on stdout !\n", 36);
    if (res == -1)
        perror("Error: ");

    res = ft__write(-1, "ft__write() is writing on stdout !\n", 36);
    if (res == -1)
        perror("Error: ");
    ft__write(1, "\n\n", 2);

//////////////////////////////////////////////////////////////////////////////////////////////////

    char *buffer = malloc(1024);
    memset(buffer, 0, 1024);

    res = ft__read(1, buffer, 1024);
    if (res == -1)
        perror("Error: ");
    printf("%s", buffer);

    res = ft__read(-1, buffer, 1024);
    if (res == -1)
        perror("Error: ");
    printf("\n\n");
    free(buffer);
//////////////////////////////////////////////////////////////////////////////////////////////////

    char *dup = ft__strdup("New string from ft__strdup !");

    printf("%s\n", dup);
    free(dup);

    return 0;
}