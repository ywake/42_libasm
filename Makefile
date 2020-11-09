# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ywake <ywake@student.42tokyo.jp>           +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/10/29 17:26:49 by ywake             #+#    #+#              #
#    Updated: 2020/11/09 10:49:53 by ywake            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME=libasm.a
SRCS=ft_strlen.s ft_strcpy.s ft_strcmp.s ft_write.s ft_read.s ft_strdup.s
SRCS_B=ft_atoi_base_bonus.s ft_create_elem_bonus.s ft_list_push_front_bonus.s ft_list_size_bonus.s ft_listadd_back_bonus.s ft_list_sort_bonus.s ft_list_remove_if_bonus.s
OBJS=$(SRCS:%.s=%.o)
OBJS_B=$(SRCS_B:%.s=%.o)

.PHONY: all clean fclean re test

all: $(NAME)

%.o: %.s
	nasm -f macho64 -o $@ $<

$(NAME): $(OBJS)
	ar rcs $(NAME) $^

bonus: $(NAME) $(OBJS_B)
	ar rcs $(NAME) $(OBJS_B)

clean:
	rm -f $(OBJS) $(OBJS_B)

fclean: clean
	rm -f $(NAME)

re: fclean all

test: bonus
	# gcc -Wall -Werror -Wextra -L. main.c -lasm -g -fsanitize=address
	# ./a.out
	bash test.sh
