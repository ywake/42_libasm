extern _ft_create_elem

section .text
	global _ft_list_push_front

_ft_list_push_front: ; void ft_list_push_front(t_list **begin_list, void *data)
	push	rbp
	mov		rbp, rsp
	sub		rsp, 0x20
	mov		QWORD[rbp-0x08], rdi	;t_list **begin_list
	mov		QWORD[rbp-0x10], rsi	;void *data
	push	rbx
.err_check:
	cmp		rdi, 0x0				;if (begin_list == NULL)
	je		.end					;	return ;
.do:
	mov		rdi, rsi
	call	_ft_create_elem			;rax = ft_create_elem(data);
	mov		rdi, QWORD[rbp-0x08]
	mov		rbx, [rdi]
	mov		QWORD[rax+8], rbx		;rax->next = *begin_list;
	mov		[rdi], rax				;*begin_list = rax;
.end:
	pop		rbx
	leave
	ret
