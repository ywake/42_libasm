section .text
	global _ft_strcpy

_ft_strcpy: ; char *ft_strcpy(char *dst, const char *src)
	push	rbp
	mov		rbp, rsp
	xor		rax, rax				;rax = 0

copy:								;while(1){
	cmp		BYTE[rsi + rax], 0x0	;	if (str[rax] == 0)
	je		end						;		break;
	mov		bl, BYTE[rsi + rax]		;
	mov		BYTE[rdi + rax], bl		;	dst[rax] = str[rax];
	inc		rax						;	rax++;
	jmp		copy					;}

end:
	mov		BYTE[rdi + rax], 0x0	;dst[rax] = '\0'
	mov		rax, rdi				;return (dst);
	leave
	ret
