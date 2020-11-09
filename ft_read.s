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
	mov		rbx, rax
	call	___error	;int *__error();
	mov		[rax], rbx	;errno = rbx
	mov		rax, -1

.end:
	pop		rbx
	leave
	ret
