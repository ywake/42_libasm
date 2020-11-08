section .text
	global _ft_strcmp

_ft_strcmp:
	push	rbp
	mov		rbp, rsp
	xor		rax, rax
	push	rbx

.loop:
	mov		bl, BYTE[rdi + rax]
	cmp		bl, BYTE[rsi + rax]
	je		.equal
	jg		.gltend
	jmp		.lesend

.equal:
	cmp		bl, 0x0
	je		.eqend
	inc		rax
	jmp		.loop

.eqend:
	mov		rax, 0x0
	jmp		.end

.gltend:
	mov		rax, 0x1
	jmp		.end

.lesend:
	mov		rax, -0x1
	jmp		.end

.end:
	pop		rbx
	leave
	ret
