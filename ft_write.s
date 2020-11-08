extern ___error
section .text
	global _ft_write

_ft_write:
	push	rbp
	mov		rbp, rsp
	mov		rax, 0x2000004
	syscall
	jc		.err
	leave
	ret

.err:
	mov		rbx, rax
	call	___error
	mov		[rax], rbx
	mov		rax, -1
	leave
	ret
