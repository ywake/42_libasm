/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: ywake <ywake@student.42tokyo.jp>           +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/10/29 17:12:16 by ywake             #+#    #+#             */
/*   Updated: 2020/11/05 18:46:02 by ywake            ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#include <errno.h>
#include <fcntl.h>
#include "libasm.h"
#include "logging.h"

void	test_strlen(char *str)
{
	size_t ret_libc;
	size_t ret_libasm;

	ret_libc = strlen(str);
	ret_libasm = ft_strlen(str);
	printf("--`"BOLD"%s"RESET"`--\n", str);
	printf((ret_libc == ret_libasm) ? GREEN : RED);
	printf("libc  : %zu\n", ret_libc);
	printf("libasm: %zu\n", ret_libasm);
	printf(RESET);
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
	printf("--"BOLD"`%s` <= `%s`"RESET"--\n", dst4libc, src);
	char *ret_libc = strcpy(dst4libc, src);
	char *ret_libasm = ft_strcpy(dst4libc, src);
	printf((strcmp(ret_libc, ret_libasm) == 0) ? GREEN : RED);
	printf("libc  : %s\n", ret_libc);
	printf("libasm: %s\n", ret_libasm);
	printf(RESET);

	// destroy test buffers
	free(dst4libasm);
	free(dst4libc);
}

void	test_strcmp(char *s1, char *s2)
{
	printf("--strcmp("BOLD"`%s`, `%s`"RESET")--\n", s1, s2);
	int	ret_libc = strcmp(s1, s2);
	int ret_asm = ft_strcmp(s1, s2);
	printf((ret_libc == ret_asm) ? GREEN : RED);
	printf("libc  : %d\n", ret_libc);
	printf("libasm: %d\n", ret_asm);
	printf(RESET);
}

void	test_write(int fd, char *str, int len)
{
	printf("--wirte("BOLD"%d, `%s`, %d"RESET")--\n", fd, str, len);
	// run libc
	printf("libc  : "YELLOW);
	fflush(stdout);
	ssize_t ret_libc = write(fd, str, len);
	int	errno_libc = errno;
	printf(RESET"\n");
	errno = 0;
	// run libasm
	printf("libasm: "YELLOW);
	fflush(stdout);
	ssize_t ret_asm = ft_write(fd, str, len);
	int errno_asm = errno;
	printf(RESET"\n");

	// evaluate
	printf((ret_libc == ret_asm && errno_libc == errno_asm) ? GREEN : RED);
	printf("libc  : ret=%zd errno=%d\n", ret_libc, errno_libc);
	printf("libasm: ret=%zd errno=%d\n", ret_asm, errno_asm);
	printf(RESET);
}

void	test_read(char *filepath, int size)
{
	printf("--%s, size:%d--\n", filepath, size);
	/*
	** run libc
	*/
	int fd_libc = open(filepath, O_RDONLY);
	char *buf_libc = calloc(sizeof(char), size + 1);
	errno = 0;
	ssize_t ret_libc = read(fd_libc, buf_libc, size);
	if (ret_libc >= 0)
		buf_libc[ret_libc] = 0;
	int	errno_libc = errno;
	/*
	** run libasm
	*/
	int fd_asm = open(filepath, O_RDONLY);
	char *buf_asm = calloc(sizeof(char), size + 1);
	errno = 0;
	ssize_t ret_asm = ft_read(fd_asm, buf_asm, size);
	if (ret_asm >= 0)
		buf_asm[ret_asm] = 0;
	int	errno_asm = errno;

	/*
	** evaluate
	*/
	printf((strcmp(buf_libc, buf_asm) == 0 && ret_libc == ret_asm && errno_libc == errno_asm) ? GREEN : RED);
	printf("libc  : fd=%d, buf=[%s], ret=%zd, errno=%d\n", fd_libc, buf_libc, ret_libc, errno_libc);
	printf("libasm: fd=%d, buf=[%s], ret=%zd, errno=%d\n", fd_asm, buf_asm, ret_asm, errno_asm);
	printf(RESET);

	/*
	** destroy
	*/
	free(buf_libc);
	close(fd_libc);
	free(buf_asm);
	close(fd_asm);
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

	printf("\n==============\n=== strcmp ===\n==============\n");
	test_strcmp("test", "test");
	test_strcmp("a", "a");
	test_strcmp("", "");
	// test_strcmp("test", NULL); // crash
	test_strcmp("test", "Test");
	test_strcmp("Test", "test");
	test_strcmp("test", "");
	test_strcmp("", "test");

	printf("\n==============\n=== write ====\n==============\n");
	test_write(1, "test", 4);
	test_write(1, "  ", 2);
	// test_write(1, "", 2); // crush
	test_write(1, "test", 2);
	test_write(1, "123456789", 9);
	printf("\n~~~ error case ~~~\n");
	test_write(42, "test", 4);
	test_write(42, "a", 1);
	test_write(42, "123456789", 9);

	printf("\n==============\n===  read  ===\n==============\n");
	test_read("test.txt", 10);
	test_read("test.txt", 5);
	test_read("test.txt", 0);
	test_read("test.txt", 100);
	printf("\n~~~ error case ~~~\n");
	test_read("nothing.txt", 10);
}
