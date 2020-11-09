section .text
	global _ft_list_remove_if

_ft_list_remove_if: ; void ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *))
	push	rbp
	mov		rbp, rsp
	sub		rsp, 0x40
	mov		QWORD[rbp-0x08], rdi	; t_list **begin_list
	mov		QWORD[rbp-0x10], rsi	; void *data_ref
	mov		QWORD[rbp-0x18], rdx	; int (*cmp)()
	mov		QWORD[rbp-0x20], rcx	; void (*free_fct)(void *)
	mov		rdi, [rdi]				; rdi = *begin_list
	mov		QWORD[rbp-0x28], rdi	; t_list *now = *begin_list
	mov		QWORD[rbp-0x30], 0x0	; t_list *prev = NULL
	push	rbx
	push	r12
.loop:								;while(1){
	mov		rbx, [rbp-0x28]			;	rbx = now;
	cmp		rbx, 0x0				;	if (now == NULL)
	je		.end					;		break;
	mov		rdi, [rbx]				;	rdi = now->data;
	mov		rsi, [rbp-0x10]			;	rsi = data_ref;
	call	[rbp-0x18]				;	rax = cmp(now->data, data_ref);
	cmp		rax, 0x0				;	if (rax == 0)
	je		.drop					;		.drop
.loop_inc:
	mov		rbx, [rbp-0x28]			;	rbx = now;
	mov		[rbp-0x30], rbx			;	prev = now;
	mov		rbx, [rbx+8]			;	rbx = now->next;
	mov		[rbp-0x28], rbx			;	now	= now->next;
	jmp		.loop					;}

.drop:
	mov		rbx, [rbp-0x30]			;rbx = prev;
	mov		r12, [rbp-0x28]			;r12 = now
	mov		r12, [r12+8]			;r12 = now->next
	cmp		rbx, 0x0				;if (prev == NULL)
	jne		.drop_cat				;{
	mov		rbx, [rbp-0x08]			;	rbx = begin_list
	mov		[rbx], r12				;	*begin_list = now->next;
	jmp		.drop_free				;}
.drop_cat:							;else
	mov		[rbx+8], r12			;	prev->next = now->next;
.drop_free:
	mov		rdi, [rbp-0x28]
	mov		rbx, [rdi+8]			;rbx = now->next;
	call	[rbp-0x20]				;freefct(now);
.drop_inc:
	mov		[rbp-0x28], rbx			;now = now->next;
	jmp		.loop

.end:
	pop		r12
	pop		rbx
	leave
	ret
