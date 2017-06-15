.section .data
	
	alfa: .ascii  "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"

	menu: .asciz "\nMENU \n 1. Cifrar \n 2. Descrifar \n 3. Creditos \n 4. Salir \nIntroduzca la opcion deseada \n"
	form: .asciz "%s"
	form2: .asciz "%s\n"
	form3: .asciz "%s \n"
	error: .asciz "Dato Invalido, Introduzca una nueva opcion\n"

.section .bss

	opcion:	.space 4
.section .text

.globl main

main: 

	movl $48, opcion
	

	pushl $menu
	call printf
	addl $4,%esp

Leer:	pushl $opcion
	pushl $form
	call scanf
	addl $8,%esp

		
	cmpl $49, opcion
	je   cifrar1

	cmpl $50, opcion
	je   cifrar1

	cmpl $51, opcion
	je creditos1
	
	cmpl $52, opcion
	je fin
	
	pushl $error
	call printf
	addl $4, %esp
	jmp Leer

cifrar1: 
	
	pushl opcion
	call cifrar
	addl $4,%esp
	jmp main

creditos1:
	
	call creditos
	jmp main

fin:	

	movl $1, %eax
	movl $0, %ebx
	int $0x80

