NAME = libasm

NAME_BONUS = libasm_bonus

LIB = libasm.a
LIB_BONUS = libasm_bonus.a

SRCS = ft_strlen.s ft_strcpy.s ft_strcmp.s ft_write.s ft_read.s ft_strdup.s

SRCS_BONUS = ft_list_size_bonus.s ft_list_push_front_bonus.s ft_list_sort_bonus.s

CC = clang -g

# CFLAGS = -Wall -Wextra -Werror

NASM = nasm 

NASM_FLAGS = -f elf64 -gdwarf 

OBJS = $(SRCS:.s=.o)
OBJS_BONUS = $(SRCS_BONUS:.s=.o)

all: $(LIB)

%.o: %.s
	$(NASM) $(NASM_FLAGS) $< -o $@

$(LIB): $(OBJS)
	ar rcs $@ $^

$(LIB_BONUS): $(OBJS) $(OBJS_BONUS)
	ar rcs $@ $^

bonus: $(LIB_BONUS)

$(NAME): main.c $(LIB)
	$(CC) $(CFLAGS) $< -o $@ $(LIB)

test: $(NAME)

$(NAME_BONUS): main_bonus.c $(LIB_BONUS)
	$(CC) $(CFLAGS) $< -o $@ $(LIB_BONUS)

test_bonus: $(NAME_BONUS)

clean:
	rm -f $(OBJS) $(OBJS_BONUS)

fclean: clean
	rm -f $(LIB) $(LIB_BONUS) $(NAME) $(NAME_BONUS)

re: fclean all

.PHONY: all bonus clean fclean re test test_bonus