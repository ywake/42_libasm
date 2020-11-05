extern ___error
section .text
	global _ft_read

_ft_read:
	push	rbp
	mov		rbp, rsp
	mov		rax, 0x2000003
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
