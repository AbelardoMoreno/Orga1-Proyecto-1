.section .data

	menu: .asciz "\nVERNAM \n Introduzca La frase a "
	form: .asciz "%s"
	form2: .asciz "%d"
	error: .asciz "Dato Invalido, Introduzca una nueva opcion\n"
	cifra: .asciz "cifrar, Marcando el final de la frase con un / \n"
	descifra: .asciz "descifrar, Marcando el final de la frase con un / \n"
	clave: .asciz "Introduzca la clave, Marcando el final con un /\n"
	listocod: .asciz "\nLa frase Codificada es %s\n"
	listodecod: .asciz "\nLa frase Decodificada es %s\n"
	presione: .asciz "\nPresione cualquier tecla para continuar\n"
	errorcla: .asciz "la clave debe ser menor o igual a la frase introducida\n"
	
.section .bss
	opcion:	.space 4
	opcion2: .space 4
	arr: .space 1024
	arrclave: .space 1024
	cantidad2: .space 4
	tamclave: .space 4
	codi: .space 4
	anything: .space 4

.section .text

.globl vernam

vernam:
	
	pushl %ebp
	movl %esp, %ebp
	movl 8(%esp), %esi #cifrar o descifrar

	movl %esi, codi
	pushl $menu
	call printf #imprime menu
	addl $4, %esp

	cmpl $49, codi
	je cifra1
	
	pushl $descifra
	call printf	#si descifra
	addl $4, %esp

	movl $0, codi #si codi es 0 esta decifrando

	jmp continua	
	
cifra1:	
	pushl $cifra
	call printf	#menu de cifrar
	addl $4, %esp
	movl $1, codi #si codi es uno esta cifrando

continua:
	
	pushl $arr
	pushl $form
	call scanf	#frase a codificar o decodificar
	addl $8, %esp


	leal arr, %edi
	pushl %edi
	call contar	#llama a contar
	addl $4,%esp
	cmpl $1,%eax
	je error2	#se prueba si son menos de 512 caracteres
	
	movl %edi, cantidad2 #tamano del arreglo
	decl cantidad2

	pushl $clave #imprime para introducr clave
	call printf
	addl $4, %esp
	
direc:	

	pushl $arrclave
	pushl $form
	call scanf
	addl $8, %esp

	leal arrclave, %edi
	pushl %edi
	call contar	#llama a contar
	addl $4,%esp
	cmpl $1,%eax
	je error3	#se prueba si son menos de 512 caracteres

	movl %edi, tamclave #tamano del arreglo clave
	decl tamclave

	movl tamclave, %ecx
	cmpl %ecx,cantidad2 #comparo cave con la frase
	jl error4

	jmp sigo

error3:  
	pushl $error
	call printf
	addl $4, %esp

	jmp direc


error2:  
	pushl $error
	call printf
	addl $4, %esp

	jmp continua

error4:
	pushl $errorcla
	call printf
	addl $4,%esp

	jmp direc

sigo:
	pushl codi
	pushl cantidad2 #sepasa la cantidad de caracteres
	leal arr, %edi
	pushl %edi #se pasa el arreglo
	pushl tamclave #se pasa el tam de clave
	leal arrclave, %esi #se pasa la clave
	pushl %esi
	call hacervernam
	addl $20, %esp

	cmpl $0, codi
	je fin1
	
	pushl %eax
	pushl $listocod
	call printf
	addl $8, %esp
fin:
	
	pushl $presione
	call printf
	addl $4, %esp

	pushl $anything
	pushl $form
	call scanf
	addl $8, %esp

	leave
	ret

fin1:

        pushl %eax
	pushl $listodecod
	call printf
	addl $8, %esp
	jmp fin
 
