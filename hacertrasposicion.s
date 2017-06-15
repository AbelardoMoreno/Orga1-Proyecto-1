.section .data
	
	alfa: .ascii  "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"
	borrador: .asciz "\0"
	form: .asciz "%s\n"
	
.section .bss
	cuantos: .space 4
	col:	.space 4
	indice: .space 4
	arr2: .space 1024
	cantidad2: .space 4
	despla: .space 4
	cod: .space 4
	indiarr: .space 4
	inditres: .space 4
	indiprinci: .space 4
	mayumin: .space 4
	arrcod: .space 1024 /*ARREGLO DONDE SE VA A GUARDAR LO CODIFICADO*/
	indiseis: .space 4
	codi: .space 4
	test: .space 4
	var: .space 4

.section .text

.globl hacertransposicion

hacertransposicion:

	pushl %ebp
	movl %esp, %ebp
	movl 8(%esp), %edi /*ARREGLO*/
	movl 12(%esp), %esi/*SE CODIFICA O DECODIFICA*/
	movl 16(%esp), %edx/*CUANTAS COLUMNAS*/
	movl 20(%esp), %eax/*CUANTOS CARACTERES TIENE EL ARREGLO -1*/
	
	movl %edi,arr2
	movl %esi, codi
	movl %edx,col
	cmpl $50,col
	je seis
	movl $3, col
	

continue:

	movl borrador, %ebx
	movl %ebx, arrcod

	movl %eax,cuantos

	movl $0, indiprinci
	movl $0, inditres
	movl $0, indiseis
	movl $0, indiarr
	
	cmpl $1, codi
	je desci
	

	
fortres:
	movl indiprinci, %ecx
	movl %ecx, inditres

dobletres:
	
	movl inditres, %ebx
	movl indiarr, %eax
	
	pushl inditres
	pushl arr2
	call carnum
	addl $8, %esp
	
	movl %eax, cod

	pushl cod
	call numcar
	addl $4, %esp
	
	movl %eax, test
	movl test, %ebx

	movb alfa(,%ebx,1), %dl

	movl indiarr, %eax

	movb %dl, arrcod(,%eax,1)

	movl inditres, %ecx
	addl col, %ecx
	movl %ecx, inditres
	
	incl indiarr
	movl cuantos, %ecx
	cmpl %ecx, inditres
	jge otranueva
	jmp dobletres
	
	
otranueva:

	incl indiprinci
	movl col, %ecx
	cmpl %ecx, indiprinci
	je fin
	movl cuantos, %ecx
	cmpl %ecx, indiprinci
	je fin
	jmp fortres	

fin:
	
	leal arrcod, %eax
	leave
	ret


seis:
	movl $6, col
	jmp continue

desci:
	

