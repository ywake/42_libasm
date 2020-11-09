extern	_ft_strlen

section .text
	global _ft_atoi_base

_ft_atoi_base: ; int ft_atoi_base(char *str, char *base)
	push	rbp
	mov		rbp, rsp
	sub		rsp, 0x30
	mov		QWORD[rbp-0x08], rdi	; char *str;
	mov		QWORD[rbp-0x10], rsi	; char *base;
	mov		BYTE[rbp-0x14], 0x0		; char is_minus = 0;
	mov		DWORD[rbp-0x18], 0x0	; int ret_num = 0;
	mov		DWORD[rbp-0x24], 0x0	; int base_len = 0;
	push	rbx						; stash
	push	r12						; stash
	push	r13						; stash
.init:
	cmp		rsi, 0x0				; if (base == NULL)
	je		.return					;	return (0);
	cmp		BYTE[rsi], 0x0			; if (base[0] == '\0')
	je		.return					;	return (0);
	mov		rdi, rsi
	call	_ft_strlen
	mov		rdi, QWORD[rbp-0x08]
	mov		DWORD[rbp-0x24], eax	; base_len = strlen(base);

.check_base:					;while(1){
	mov		r12b, BYTE[rsi];	{
	cmp		r12b, '+'			;	if(*base == '+')
	je		.return				;		return(0);
	cmp		r12b, '-'			;	if(*base == '-')
	je		.return				;		return(0);
	cmp		r12b, ' '			;	if (*base == ' ')
	je		.return				;		return(0);
	cmp		r12b, 9				;	if (*base < 9)
	jl		.check_base_same	;		;
	cmp		r12b, 13			;	else if (*base > 13)
	jg		.check_base_same	;		;
	jmp		.return				;	else{ return(0) ;}
.check_base_same:
	mov		rbx, 1				;	j = 1;
.check_base_same_loop:				;	while(1)
	movzx	r12, BYTE[rsi + rbx];	{
	cmp		r12, 0x0			;		if(base[j] == 0)
	je		.check_base_inc		;			break;
	cmp		BYTE[rsi], r12b		;		else if(*base == base[j])
	je		.return				;			return(0);
	inc		rbx					; 		j++;
	jmp		.check_base_same_loop	;	}
.check_base_inc:
	inc		rsi					;	base++;
	cmp		BYTE[rsi], 0x0		;	if(*base == 0)
	je		.skip_space			;		break;
	jmp		.check_base			;}

.skip_space:
	xor		rbx, rbx				;i = 0
.is_space:							;while(1){
	cmp		BYTE[rdi + rbx], ' '	;	if (str[i] == ' ')
	je		.is_space_inc			;		i++;
	cmp		BYTE[rdi + rbx], 9		;	else if (str[i] < 9)
	jl		.is_sign				;		break;
	cmp		BYTE[rdi + rbx], 13		;	else if (str[i] > 13)
	jg		.is_sign				;		break;
	jmp		.is_space_inc			;	else
.is_space_inc:						;
	inc		rbx						;		i++;
	jmp		.is_space				;}

.is_sign:							;while(1){
	cmp		BYTE[rdi + rbx], '+'	;	if (str[i] == '+')
	je		.is_sign_inc			;		i++;
	cmp		BYTE[rdi + rbx], '-'	;	else if (str[i] == '-')
	je		.is_minus				;		is_minus ^= 1;i++;
	jmp		.atoi_base				;	else{ break; }
.is_minus:							;
	xor		BYTE[rbp - 0x14], 0x1	; // is_minus ^= 1;
.is_sign_inc:						;
	inc		rbx						; // i++;
	jmp		.is_sign				;}

.atoi_base:							;while(1){
	mov		r12b, BYTE[rdi + rbx]	;	r12 = str[i];
	mov		rsi, QWORD[rbp-0x10]	;	rsi = base;
	xor		r13, r13				;	j = 0;
.search_from_base:					;	while(1){
	cmp		BYTE[rsi + r13], 0x0	;		if (base[j] == 0)
	je		.return					;			end;
	cmp		r12b, BYTE[rsi + r13]	;		else if (str[i] == base[j])
	je		.atoi					;			break;
	inc		r13						;		j++;
	jmp		.search_from_base		;	}
.atoi:
	movsx	rax, DWORD[rbp-0x24]	;	rax = base_len
	mul		DWORD[rbp-0x18]			;	rax *= ret_num;
	add		rax, r13				;	rax += j
	mov		DWORD[rbp-0x18], eax	;	ret_num = rax;
	inc		rbx						;	i++;
	jmp		.atoi_base				;}

.return:
	mov		rax, 1				; rax = 1
	cmp		BYTE[rbp-0x14], 1	; if (!is_minus)
	jne		.end				;	;
	mov		rax, -1				; else { rax = -1; }
.end:
	mul		DWORD[rbp-0x18]		; rax *= ret_num;
	pop		r13
	pop		r12
	pop		rbx
	leave
	ret							; return (ret_num);
