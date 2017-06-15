.section .data

	menu: .asciz "\n\n\n\n\nDESCIFRAR \n 1. Sustitucion \n 2. Transposicion \n 3. Cifrador Vigenere \n 4. Cifrador Vernam \n 5. Retornar \n Introduza la opcion deseada \n"
	form: .asciz "%s"
	error: .asciz "Dato Invalido\n"

.section .bss

	opcion:	.space 4
.section .text

.globl descifrar

descifrar: 

	movl $48, opcion
	

	pushl $menu
	call printf
	addl $4,%esp

	pushl $opcion
	pushl $form
	call scanf
	addl $8,%esp

		

	cmpl $49, opcion
	je   sustitucion

	cmpl $50, opcion
	je   transposicion

	cmpl $51, opcion
	je vigenere
	
	cmpl $52, opcion
	je vernam
	
	cmpl $53, opcion
	je fin


	pushl $error
	call printf
	addl $4, %esp
sustitucion:
transposicion:
vigenere:
vernam:	
	jmp cifrar
	
fin:	ret


