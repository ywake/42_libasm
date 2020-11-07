extern	_ft_strlen

section .text
	global _ft_atoi_base

_ft_atoi_base:
	push	rbp
	mov		rbp, rsp
	sub		rsp, 0x30
	mov		QWORD[rbp-0x08], rdi	; char *str
	mov		QWORD[rbp-0x10], rsi	; char *base
	mov		BYTE[rbp-0x14], 0x0		; char is_minus;
	mov		DWORD[rbp-0x18], 0x0	; int ret_num;
	mov		DWORD[rbp-0x24], 0x0	; int now_digit_num;
	push	rbx
	push	r12
	mov		r12, [rbp-0x08]			; r12 = rdi
	xor		rbx, rbx				; i = 0

.is_space:
	cmp		BYTE[r12 + rbx], ' '	; if (str[i] == ' ')
	je		.skipspace
	cmp		BYTE[r12 + rbx], 9		; if (str[i] < 9)
	jl		.is_sign
	cmp		BYTE[r12 + rbx], 13	; if (str[i] > 13)
	jg		.is_sign
	jmp		.skipspace

.skipspace:								; while(is_space(str[i]))
	inc		rbx							;	i++
	jmp		.is_space

.is_sign:
	cmp		BYTE[r12 + rbx], '+'
	je		.loopsign
	cmp		BYTE[r12 + rbx], '-'	;	if (str[i] == '-')
	je		.is_minus					;		is_minus ^= 1
	jmp		.atoi

.is_minus:
	xor		BYTE[rbp - 0x14], 0x1

.loopsign:								; while(is_sign(str[i]))
	inc		rbx							;	i++;
	jmp		.is_sign

.atoi:										; while(isdigit(str[i]))
	cmp		BYTE[r12 + rbx], '0'
	jl		.end
	cmp		BYTE[r12 + rbx], '9'
	jg		.end
	movzx	rax, BYTE[r12 + rbx]		; rax = str[i]
	sub		rax, '0'						; rax -= '0'
	mov		[rbp-0x24], rax					; now_digit_num = rax
	mov		rax, 10
	mul		DWORD[rbp-0x18]					; ret_num *= 10
	add		rax, [rbp-0x24]					; ret_num += now_digit_num
	mov		DWORD[rbp-0x18], eax
	inc		rbx
	jmp		.atoi

.end:
	pop		r12
	pop		rbx
	mov		rax, 1
	cmp		BYTE[rbp-0x14], 1
	jne		.ret
	mov		rax, -1
.ret:
	mul		DWORD[rbp-0x18]
	leave
	ret
