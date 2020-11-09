section .text
	global _ft_strlen

_ft_strlen: ; size_t ft_strlen(char *str)
	push	rbp
	mov		rbp, rsp
	xor		rax, rax				;rax = 0

count:								;wihle(1){
	cmp		BYTE [rdi + rax], 0x0	;	if (str[rax] == 0)
	je		end						;		return (rax);
	inc		rax						;	i++;
	jmp		count					;}

end:								;return (rax);
	leave
	ret
