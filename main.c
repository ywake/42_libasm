/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: ywake <ywake@student.42tokyo.jp>           +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/10/29 17:12:16 by ywake             #+#    #+#             */
/*   Updated: 2020/11/04 02:01:16 by ywake            ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "libasm.h"

void	test_strlen(char *str)
{
	printf("--`%s`--\n", str);
	printf("libc  : %zu\n", strlen(str));
	printf("libasm: %zu\n", ft_strlen(str));
}

void	test_strcpy(int destsize, char *src)
{
	// make test buffers
	char *dst4libc = malloc((destsize + 1) * sizeof(char));
	memset(dst4libc, 'a', destsize);
	dst4libc[destsize] = 0;
	char *dst4libasm = malloc((destsize + 1) * sizeof(char));
	dst4libasm[destsize] = 0;
	memset(dst4libc, 'a', destsize);

	// testing
	printf("--`%s` <= `%s`--\n", dst4libc, src);
	printf("libc  : %s\n", strcpy(dst4libc, src));
	printf("libasm: %s\n", ft_strcpy(dst4libc, src));

	// destroy test buffers
	free(dst4libasm);
	free(dst4libc);
}

int	main(void)
{
	printf("==============\n=== strlen ===\n==============\n");
	test_strlen("test");
	test_strlen("");
	test_strlen("あいうえお");
	// test_strlen(NULL); // crash

	printf("\n==============\n=== strcpy ===\n==============\n");
	test_strcpy(4, "test");
	test_strcpy(4, "A");
	test_strcpy(4, "");
	// test_strcpy(1, "test"); // crash
	test_strcpy(1, "A");
	test_strcpy(0, "");
	// test_strcpy(4, NULL); // crash
	// test_strcpy(0, NULL); // crash
}
