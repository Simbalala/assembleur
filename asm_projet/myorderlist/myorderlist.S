
%define PROT_NONE   0x00
%define PROT_READ   0x01
%define PROT_WRITE  0x02
%define PROT_EXEC   0x04

%define MAP_SHARED  0x01
%define MAP_PRIVATE 0x02
%define MAP_TYPE    0x0F
%define MAP_FIXED   0x10
%define MAP_ANON    0x20

section .text
    global orderlist


swap:
    mov r8, [rdi + 8 * rdx]
    mov r9, [rdi + 8 * (rdx + 1)]
    mov [rdi + 8 * rdx], r9
    mov [rdi + 8 * (rdx + 1)], r8
    inc rdx
    jmp loop_2

orderlist:
    xor rax, rax
    mov rcx, 0
    mov rdx, 0

orderlist_loop:
    cmp rcx, rsi
    jg exit
    inc rcx
    mov rdx, 0
    jmp loop_2

loop_2:
    mov r10, rsi
    sub r10, rcx
    sub r10,1
    cmp rdx, r10
    jg orderlist_loop
    
    mov r8, [rdi + 8 * rdx]
    mov r9, [rdi + 8 * (rdx + 1)]
    cmp r8, r9
    jg swap
    inc rdx
    jmp loop_2

exit:
    ret
    


; write_list:
;     jmp mmap
;         ; mov r8, [rdi]
;     ; mov [r9], r8

;     ; mov	rdi,1			; fd
;     ; mov rsi, r9
; 	; mov	rdx, 2 	; count
; 	; mov	rax,1	 		; write(2)
; 	; syscall

; 	; exit(result)
; 	mov	rdi,0			; result
; 	mov	rax,60			; exit(2)
; 	syscall
;     ret

; mmap:
;     mov r9,   0                      ; and there's no file offset in either case.
;     mov rax, 9          ; set up mmap()
;     mov rdx, PROT_READ|PROT_WRITE    ; We'd like a read/write mapping
;     mov rdi,  0                      ; at no pre-specified memory location.
;     mov rsi, r14                     ; Length of the mapping in bytes.
;     syscall                        ; do mmap() system call.
;     test rax, rax                  ; Return value will be in rax.
;     js error                   ; If it's negative, that's trouble.

;     mov rbp, rax
;     mov	rdi,0			; result
; 	mov	rax,60			; exit(2)
; 	syscall
;     ret

; error:
;  mov rbp, rax
;     mov	rdi,0			; result
;     mov	rax,60			; exit(2)
;     syscall
;   mov rdi, rax                   ; In case of error, return code is -errno...
;   mov rax, -1
;   neg rdi                        ; ...so negate to get actual errno
;   syscall

 
;     ret
