.section .data
	
	alfa: .ascii  "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"
	borrador: .asciz "\0"
	form: .asciz "%s\n"
	form2: .asciz "%d\n"
	
.section .bss
	tamfra:	.space 4
	tamcla: .space 4
	arrcla: .space 1024
	arrfra: .space 1024 
	cantidad2: .space 4
	cod: .space 4
	franum: .space 4
	clanum: .space 4
	indifra: .space 4
	indicla: .space 4
	arrcod: .space 1024 /**ARREGLO DONDE SE VA A GUARDAR LO CODIFICADO**/
	codi: .space 4
	mayuminfra: .space 4
	mayumincla: .space 4
.section .text

.globl hacervigenere

hacervigenere:

	pushl %ebp
	movl %esp, %ebp
	movl 8(%esp), %edi /** ARREGLO clave*/
	movl 12(%esp), %esi/*; tam clave*/
	movl 16(%esp), %edx/*; arreglo frase*/
	movl 20(%esp), %eax/*; tam frase*/
	movl 24(%esp), %ebx /* si codifica o decodifica*/
	
	movl %ebx, codi
	movl %edi,arrcla
	movl %esi, tamcla
	movl %edx,arrfra
	movl %eax, tamfra
	
	xorl %edx,%edx
	movl borrador, %edx
	movl %edx, arrcod

	movl $0, indifra
	movl $0, indicla

	
for:
	
	pushl indifra
	pushl arrfra
	call carnum
	addl $8,%esp
	
	movl %eax, franum

	pushl indicla
	pushl arrcla
	call carnum
	addl $8,%esp
	
	movl %eax, clanum
	movl franum, %ebx

	cmpl $97,franum
	jge min
	movl $0, mayuminfra
keep:

	cmpl $97,clanum
	jge mincla
	movl $0, mayumincla

next:
	
	movl mayumincla, %ecx
	cmpl %ecx, mayuminfra
	jne fix
	
forward:
	

	cmpl $0,mayuminfra
	je modificar

	xorl %ecx,%ecx
	movl clanum, %ecx
	subl $97, %ecx
	movl %ecx,clanum
salto:
	cmpl $0,codi
	je descifrar

	movl franum, %ebx
	addl clanum,%ebx #sumo para codificar
	movl %ebx, cod

sigo:

	cmpl $0, mayuminfra
	je check

	cmpl $97,cod
	jl arreglar
	cmpl $122,cod
	jg arreglar

listo:
	
	pushl cod
	call numcar #t da el numero en el arreglo alfa
	addl $4, %esp

	movl %eax, cod

	movl cod, %edx
	movl indifra, %ebx 

	movb alfa(,%edx,1), %cl
	movb %cl, arrcod(,%ebx,1)


	incl indifra
	incl indicla
	
	movl indicla,%ecx
	cmpl tamcla,%ecx
	jge reiniciar

continua:

	movl indifra, %edx
 	cmpl tamfra, %edx
	jge fin
	jmp for
fin:
	
	leal arrcod, %eax
	leave
	ret

reiniciar:
	movl $0,indicla #resetea la clave para simular un concatenamiento
	jmp continua

descifrar:	
	movl franum, %ebx
	subl clanum,%ebx #resto para decodificar
	movl %ebx, cod
	jmp sigo


min:
	movl $1, mayuminfra
	jmp keep

mincla:

	movl $1, mayumincla
	jmp next

fix:

	cmpl $1, mayumincla
	je refix
	movl clanum, %ecx
	addl $32, %ecx #sumar 32 de min a mayus
	movl %ecx, clanum
	jmp forward

refix:
	movl clanum, %ecx
	subl $32, %ecx #resta 32 de min a mayus
	movl %ecx, clanum
	jmp forward

check:
	cmpl $65,cod
	jl arreglar
	cmpl $90,cod
	jg arreglar
	jmp listo

arreglar:
	cmpl $0, codi
	je arreglar2
	xorl %ecx,%ecx
	movl cod, %ecx
	subl $26,%ecx
	movl %ecx,cod
	jmp listo

arreglar2:
	xorl %ecx,%ecx
	movl cod, %ecx
	addl $26,%ecx
	movl %ecx,cod
	jmp listo
	
modificar:
	xorl %ecx,%ecx
	movl clanum, %ecx
	subl $65,%ecx
	movl %ecx,clanum
	jmp salto

	