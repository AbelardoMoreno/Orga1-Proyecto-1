.section .data

	menu: .asciz "\nSUSTITUCION \n Introduzca La frase a "
	form: .asciz "%s"
	form2: .asciz "%d"
	error: .asciz "Dato Invalido, Introduzca una nueva opcion\n"
	cifra: .asciz "cifrar, Marcando el final de la frase con un / \n"
	descifra: .asciz "descifrar, Marcando el final de la frase con un / \n"
	direccion: .asciz "Introduzca hacia donde desplazar la frase\n 1.Derecha\n 2.Izquierda\n"
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

.globl sustitucion

sustitucion:
	
	pushl %ebp
	movl %esp, %ebp
	movl 8(%esp), %esi

	pushl $menu
	call printf #imprime menu
	addl $4, %esp

	cmpl $49, %esi
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

	pushl $direccion #OPCION 1 ES HACIA DONDE MOVERSE
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

	pushl $cantidad #CUANTOS MOVERSE SE GUARDAN EN OPCION2
	call printf
	addl $4, %esp

recover:
	
	pushl $opcion2
	pushl $form2
	call scanf
	addl $8, %esp
	
	movl opcion2, %ebx
	cmpl $0, %ebx
	jle error1
	cmpl $20, %ebx
	jge error1
	

	jmp sigo

error1:  
	pushl $error
	call printf
	addl $4, %esp

	jmp recover

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
	pushl opcion #hacia donde se van a desplazar
	pushl opcion2 #cuantos se van a desplazar
	leal arr, %edi
	pushl %edi #se pasa el arreglo
	call hacersustitucion
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
