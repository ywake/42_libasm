/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: ywake <ywake@student.42tokyo.jp>           +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/10/29 17:12:16 by ywake             #+#    #+#             */
/*   Updated: 2020/11/03 18:05:06 by ywake            ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdio.h>
#include <string.h>
#include "libasm.h"

# define STRLEN(str)\
printf("--`%s`--\n", str);\
printf("libc  : %zu\n", strlen(str));\
printf("libasm: %zu\n", ft_strlen(str));

void	test_strlen()
{
	printf("==============\n=== strlen ===\n==============\n");
	STRLEN("test");
	STRLEN("");
	STRLEN("あいうえお");
}

int	main(void)
{
	test_strlen();
}
