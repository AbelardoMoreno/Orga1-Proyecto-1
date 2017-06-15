.section .data

	menu: .asciz "\nCIFRAR/DESCIFRAR \n 1. Sustitucion \n 2. Transposicion \n 3. Cifrador Vigenere \n 4. Cifrador Vernam \n 5. Retornar \n IntroduzCa la opcion deseada \n"
	form: .asciz "%s"
	error: .asciz "Dato Invalido, Introduzca una nueva opcion\n"

.section .bss

	opcion:	.space 4

.section .text

.globl cifrar

cifrar: 
	
	pushl %ebp
	movl %esp, %ebp	
	movl 8(%ebp), %esi

	movl $48, opcion
	
	pushl $menu
	call printf
	addl $4,%esp

Leer:	
	movl $48, opcion

	pushl $opcion
	pushl $form
	call scanf
	addl $8,%esp

		

	cmpl $49, opcion
	je   sustitucion1

	cmpl $50, opcion
	je   transposicion1

	cmpl $51, opcion
	je vigenere1
	
	cmpl $52, opcion
	je vernam1
	
	cmpl $53, opcion
	je fin

	
	pushl $error
	call printf
	addl $4, %esp
	jmp Leer

sustitucion1:
	
	pushl %esi
	call sustitucion
	addl $4,%esp
	jmp fin

transposicion1:
	pushl %esi
	call transposicion
	addl $4,%esp
	jmp fin


vigenere1:
	
	pushl %esi
	call vigenere
	addl $4,%esp
	jmp fin

vernam1:
	pushl %esi
	call vernam
	addl $4,%esp

fin:	leave
	ret


