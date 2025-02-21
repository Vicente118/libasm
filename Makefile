NAME = libasm

NAME_BONUS = libasm_bonus

LIB = libasm.a

SRCS = ft__strlen.s ft__strcpy.s ft__strcmp.s ft__write.s ft__read.s ft__strdup.s

SRCS_BONUS = ft__list__size__bonus.s 

CC = gcc

# CFLAGS = -Wall -Wextra -Werror

NASM = nasm 

NASM_FLAGS = -f elf64

OBJS = $(SRCS:.s=.o)

OBJS_BONUS = $(SRCS_BONUS:.s=.o)


%.o : %.s 
	$(NASM) $(NASM_FLAGS) $< -o $@

all : $(LIB)

$(LIB) : $(OBJS)
	ar rcs $(LIB) $(OBJS)

bonus : $(OBJS) $(OBJS_BONUS)
	ar rcs $(LIB) $(OBJS) $(OBJS_BONUS)

test :
	$(CC) $(CFLAGS) -no-pie main.c $(LIB) -o $(NAME)

test_bonus :
	$(CC) $(CFLAGS) -no-pie main_bonus.c $(LIB) -o $(NAME_BONUS)

clean :
	rm -f $(OBJS) $(OBJS_BONUS)

fclean : clean
	rm -f $(LIB) $(NAME) $(NAME_BONUS)

re : fclean all

