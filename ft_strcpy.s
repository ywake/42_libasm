section .text
	global _ft_strcpy

_ft_strcpy:
	push	rbp
	mov		rbp, rsp
	xor		rax, rax

copy:
	cmp		BYTE[rsi + rax], 0x0
	je		end
	mov		bl, BYTE[rsi + rax]
	mov		BYTE[rdi + rax], bl
	inc		rax
	jmp		copy

end:
	mov		BYTE[rdi + rax], 0x0
	mov		rax, rdi
	leave
	ret
