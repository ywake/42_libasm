# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ywake <ywake@student.42tokyo.jp>           +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/10/29 17:26:49 by ywake             #+#    #+#              #
#    Updated: 2020/11/03 17:59:06 by ywake            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME=libasm.a
SRCS=ft_strlen.s
OBJS=$(SRCS:%.s=%.o)

.PHONY: all clean fclean re test

all: $(NAME)

%.o: %.s
	nasm -f macho64 -o $@ $<

$(NAME): $(OBJS)
	ar rcs $(NAME) $^

clean:
	rm -f $(OBJS)

fclean: clean
	rm -f $(NAME)

re: fclean all

test: $(NAME)
	gcc -L. main.c -lasm
