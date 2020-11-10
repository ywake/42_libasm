extern ___error
section .text
	global _ft_read

_ft_read: ; ssize_t ft_read(int fildes, void *buf, size_t nbyte)
	push	rbp
	mov		rbp, rsp
	push	rbx
	mov		rax, 0x2000003
	syscall
	jc		.err
	jmp		.end

.err:
	push	rax
	call	___error	;int *__error();
	pop		rbx
	mov		[rax], rbx	;errno = rbx
	mov		rax, -1

.end:
	pop		rbx
	leave
	ret
