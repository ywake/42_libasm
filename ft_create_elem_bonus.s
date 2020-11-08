extern	_malloc

section .text
	global _ft_create_elem

_ft_create_elem: ; t_list *ft_create_elem(void *data)
	push	rbp
	mov		rbp, rsp
	sub		rsp, 0x20
	mov		QWORD[rbp-0x08], rdi	;void *data
	mov		QWORD[rbp-0x10], 0x0	;t_list *lst = NULL;
	mov		edi, 16
	call	_malloc
	cmp		rax, 0x0
	je		.err
	mov		QWORD[rbp-0x10], rax	;lst = malloc(sizeof(t_list));
	mov		rdi, QWORD[rbp-0x08]
	mov		QWORD[rax], rdi				;lst->data = data;
	mov		QWORD[rax+8], 0x0			;lst->next = NULL;
.end:
	leave
	ret

.err:
	mov		rax, 0x0
	jmp		.end
