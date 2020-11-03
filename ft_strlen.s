section .text
	global _ft_strlen

_ft_strlen:
	push	rbp
	mov		rbp, rsp
	xor		rax, rax

count:
	cmp		BYTE [rdi + rax], 0x0
	je		end
	inc		rax
	jmp		count

end:
	leave
	ret
