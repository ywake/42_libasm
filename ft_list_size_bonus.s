section .text
	global _ft_list_size

_ft_list_size: ;int ft_list_size(t_list *begin_list)
	push	rbp
	mov		rbp, rsp
	sub		rsp, 0x20
	mov		QWORD[rbp-0x08], rdi;t_list *begin_list
	push	rbx
	xor		rbx, rbx			;i = 0
.loop:							;while(1){
	cmp		rdi, 0x0			;	if (!now)
	je		.end				;		return (i);
	mov		rdi, [rdi+8]		;	now = now->next;
	inc		rbx					;	i++;
	jmp		.loop				;}
.end:
	mov		rax, rbx
	pop		rbx
	leave
	ret
