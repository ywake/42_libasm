extern ___error
extern _malloc
extern _ft_strlen
extern _ft_strcpy

section .text
	global _ft_strdup

_ft_strdup:
	push	rbp
	mov		rbp, rsp
	mov		rbx, rdi
	call	_ft_strlen
	mov		rdi, rax
	inc		rdi
	call	_malloc
	cmp		rax, 0x0
	je		.end
	mov		rdi, rax
	mov		rsi, rbx
	call	_ft_strcpy
	jmp		.end

.end:
	leave
	ret
