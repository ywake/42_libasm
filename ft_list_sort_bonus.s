extern _ft_lstadd_back

section .text
	global _ft_list_sort

_ft_list_sort: ; void ft_list_sort(t_list **begin_list, int (*cmp)());
	push	rbp
	mov		rbp, rsp
	sub		rsp, 0x40
	mov		QWORD[rbp-0x08], rdi	;t_list **begin_list
	mov		QWORD[rbp-0x10], rsi	;int (*cmp)()
	push	rbx
	push	r12

.check_end:
	cmp		rdi, 0x0				;if (begin_list == NULL)
	je		.end					;	return ;
	mov		rbx, [rdi]				;std = *begin_list
	cmp		rbx, 0x0				;if (std == NULL)
	je		.end					;	return ;
	mov		r12, [rbx+8]			;target = std->next;
	cmp		r12, 0x0				;if (target == NULL)
	je		.end					;	return ;
.init:
	mov		QWORD[rbp-0x18], rbx	;t_list *std = *begin_list
	mov		QWORD[rbp-0x20], r12	;t_list *target = std->next
	mov		QWORD[rbx+8], 0x0		;std->next = NULL;
	mov		QWORD[rbp-0x28], 0x0	;t_list *next = NULL
	mov		QWORD[rbp-0x30], 0x0	;t_list *left = NULL
	mov		QWORD[rbp-0x38], 0x0	;t_list *right = NULL

.loop:								;while(1){
	mov		rbx, QWORD[rbp-0x20]	;
	cmp		rbx, 0x0				;	if (target == NULL)
	je		.recurcive				;		break;
	mov		r12, [rbx+8]
	mov		QWORD[rbp-0x28], r12	;	next = target->next;
	mov		QWORD[rbx+8], 0x0		;	target->next = NULL;
	mov		rdi, QWORD[rbp-0x18]
	mov		rdi, [rdi]				;	rdi = std->data;
	mov		rsi, [rbx]				;	rsi = target->data;
	call	QWORD[rbp-0x10]			; 	rax = cmp(rdi, rsi);
	cmp		rax, 0x0				;	if (rax <= 0) // rdi < rsi
	jg		.less
	mov		rdi, rbp				;	// mov rdi, rbp-0x38
	sub		rdi, 0x38				;	rdi = &right
	mov		rsi, QWORD[rbp-0x20]	;
	call	_ft_lstadd_back			;		ft_lstadd_back(&right, target)
	jmp		.loop_inc
.less:								;	else
	mov		rdi, rbp
	sub		rdi, 0x30				;	rdi = &left
	mov		rsi, QWORD[rbp-0x20]	;
	call	_ft_lstadd_back			;		ft_lstadd_back(&left, target)
.loop_inc:
	mov		rbx, QWORD[rbp-0x28]
	mov 	QWORD[rbp-0x20], rbx	; target = next
	jmp		.loop					;}

.recurcive:
	mov		rdi, rbp				; // mov rdi, rbp-0x30
	sub		rdi, 0x30				;rdi = &left
	mov		rsi, QWORD[rbp-0x10]
	call	_ft_list_sort			;ft_list_sort(&left, cmp);
	mov		rdi, rbp				; // mov rdi, rbp-0x30
	sub		rdi, 0x30				;rdi = &left
	mov		rsi, QWORD[rbp-0x18]
	call	_ft_lstadd_back			;ft_lstadd_back(&left, std);
	mov		rdi, rbp				; // mov rdi, rbp-0x38
	sub		rdi, 0x38				;rdi = &right
	mov		rsi, QWORD[rbp-0x10]
	call	_ft_list_sort			;ft_list_sort(&right, cmp);
	mov		rdi, rbp				; // mov rdi, rbp-0x38
	sub		rdi, 0x30				;rdi = &left
	mov		rsi, QWORD[rbp-0x38]
	call	_ft_lstadd_back			;ft_lstadd_back(&left, right);
	mov		rbx, QWORD[rbp-0x08]
	mov		r12, QWORD[rbp-0x30]
	mov		[rbx], r12				; *begin_list = left

.end:
	pop		r12
	pop		rbx
	leave
	ret
