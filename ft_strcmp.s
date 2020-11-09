section .text
	global _ft_strcmp

_ft_strcmp: ; int ft_strcmp(const char *s1, const char *s2)
	push	rbp
	mov		rbp, rsp
	push	rbx
	push	r12
	xor		rax, rax			;i = 0

.loop:							;while(1){
	mov		bl, BYTE[rdi + rax]	;
	cmp		bl, BYTE[rsi + rax]	;	if (s1[i] != s2[i])
	jne		.subend				;		.subend
	cmp		BYTE[rdi + rax], 0x0;	if (s1[i] == '\0')
	je		.eqend				;		.eqend
	inc		rax					;	i++;
	jmp		.loop				;}

.eqend:
	xor		rax, rax			;rax = 0
	jmp		.end

.subend:
	movzx	rbx, BYTE[rdi + rax]
	movzx	r12, BYTE[rsi + rax]
	sub		rbx, r12			;rax = s1[i] - s2[i]
	mov		rax, rbx
	.end

.end:							;return (rax);
	pop		r12
	pop		rbx
	leave
	ret
