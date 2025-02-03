section .data
	pong db "Match", 0 	; what we send if a match is found
	SMALL_BUFFER db 0 	; buffer for comparing
section .text
	global _start
_start:
	; EXAMPLE, find 9
	mov	rbx, 2 		;move 2 to rax
	add	rbx, 7		;add 7 to rax
	push	4		;example value
	push	rbx		;rax which now holds 9
	push	5		;example value
	mov	rax,9 		; what result we are trying to find

	call	match ; call the match label aka "function"
	jmp	exit
exit:
	mov	rax,60
	xor	rdi,rdi
	syscall
match:
	mov	rbx, [rsp+16]
	mov	rcx, [rsp+8]
	mov	rdx, [rsp]

	cmp	rax,rbx
	mov	byte [SMALL_BUFFER],bl
	je match_found	; jump somewhere, this can be used to make something like cases in python
	
	cmp	rax,rcx
	mov	byte [SMALL_BUFFER],cl
	je match_found
	
	cmp	rax,rdx
	mov	byte [SMALL_BUFFER],dl
	je match_found
	ret
match_found:
	cmp	[SMALL_BUFFER],rax
	jne	match_return
	mov	rax,1
	mov	rdi,1
	lea	rsi,[SMALL_BUFFER]
	mov	rdx,2
	syscall
	mov	rax,1
	mov	rdi,1
	lea	rsi,[pong]
	mov	rdx,6
	syscall
	call match_return
match_return:
	ret
