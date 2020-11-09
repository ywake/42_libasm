extern ___error
extern _malloc
extern _ft_strlen
extern _ft_strcpy

section .text
	global _ft_strdup

_ft_strdup: ; char			*ft_strdup(const char *s1)
	push	rbp
	mov		rbp, rsp
	push	rbx

	mov		rbx, rdi	;rbx = s1;
	call	_ft_strlen	;len = ft_strlen(s1);
	mov		rdi, rax	;
	inc		rdi			;
	call	_malloc		;ptr = malloc(len + 1)
	cmp		rax, 0x0	;if (ptr == NULL)
	je		.end		;	return (NULL);
	mov		rdi, rax	;
	mov		rsi, rbx	;
	call	_ft_strcpy	;ft_strcpy(ptr, s1);
	jmp		.end

.end:
	pop		rbx
	leave
	ret
