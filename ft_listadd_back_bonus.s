section .text
	global _ft_lstadd_back

_ft_lstadd_back: ; void ft_lstadd_back(t_list **lst, t_list *new)
	push	rbp
	mov		rbp, rsp
	sub		rsp, 0x20
	mov		[rbp-0x08], rdi	;t_list **lst
	mov		[rbp-0x10], rsi	;t_list	*new
	push	rbx
	push	r12
.check_err:
	cmp		rdi, 0x0		;if (lst == NULL)
	je		.end			;	return ;
	cmp		rsi, 0x0		;if (new == NULL)
	je		.end			;	return ;
	cmp		QWORD[rdi], 0x0	;if (*lst == NULL)
	jne		.get_last
	mov		[rdi], rsi		;	*lst = new
	jmp		.end			;	return ;
.get_last:					;else
	mov		rbx, [rdi]		;	now = *lst
.loop:						;	while(1){
	cmp		QWORD[rbx+8], 0x0;		if (now->next == NULL)
	je		.return			;			break;
	mov		rbx, [rbx+8]	;		now = now->next
	jmp		.loop			;	}
.return:
	mov		[rbx+8], rsi	;	now->next = new
.end:
	pop		r12
	pop		rbx
	leave
	ret
