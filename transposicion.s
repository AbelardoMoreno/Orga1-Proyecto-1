.section .data

	menu: .asciz "\nTRANSPOSICION \n Introduzca La frase a "
	form: .asciz "%s"
	form2: .asciz "%d"
	error: .asciz "Dato Invalido, Introduzca una nueva opcion\n"
	cifra: .asciz "cifrar, Marcando el final de la frase con un / \n"
	descifra: .asciz "descifrar, Marcando el final de la frase con un / \n"
	column: .asciz "Introduzca la cantidad de columnas deseasa\n 1.Tres\n 2.Seis\n"
	cantidad: .asciz "Introduzca cuantas posiciones desea moverse (01 al 19)\n"
	listocod: .asciz "\nLa frase Codificada es %s\n"
	listodecod: .asciz "\nLa frase Decodificada es %s\n"
	presione: .asciz "\nPresione cualquier tecla para continuar\n"
	
.section .bss
	opcion:	.space 4
	opcion2: .space 4
	arr: .space 1024
	cantidad2: .space 4
	codi: .space 4
	anything: .space 4

.section .text

.globl transposicion

transposicion:
	
	pushl %ebp
	movl %esp, %ebp
	movl 8(%esp), %esi #SI CODIFICA O DECODIFICA

	movl %esi, codi

	pushl $menu
	call printf #imprime menu
	addl $4, %esp

	cmpl $49, codi
	je cifra1
	
	pushl $descifra
	call printf	#si descifra
	addl $4, %esp

	movl $0, codi

	jmp continua	
	
cifra1:	
	pushl $cifra
	call printf	#menu de cifrar
	addl $4, %esp
	movl $1, codi

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

	pushl $column #OPCION ES CUANTAS COLUMNAS
	call printf
	addl $4, %esp
	
direc:	

	movl $48,opcion	
	pushl $opcion
	pushl $form
	call scanf
	addl $8, %esp

	cmpl $49,opcion
	jl error3
	cmpl $50,opcion
	jg error3	
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
	
sigo:
	
	pushl cantidad2 #sepasa la cantidad de caracteres
	pushl opcion #cuantas columnas
	pushl codi
	leal arr, %edi
	pushl %edi #se pasa el arreglo
	call hacertransposicion
	addl $16, %esp

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
