.section .data
	
	alfa: .ascii  "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","/"
	borrador: .asciz "\0"
	form: .asciz "%s\n"
	
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
	mayuminfra: .space 4
	mayumincla: .space 4
	codi: .space 4

.section .text

.globl hacervernam

hacervernam:

	pushl %ebp
	movl %esp, %ebp
	movl 8(%esp), %edi /** ARREGLO clave*/
	movl 12(%esp), %esi/*; tam clave*/
	movl 16(%esp), %edx/*; arreglo frase*/
	movl 20(%esp), %eax/*; tam frase*/
	movl 24(%esp), %ecx /*cifra o descifra*/
	
	movl %ecx, codi
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

	cmpl $97, franum
	jge minfra
	movl $1, mayuminfra

hakuna:

	cmpl $97, clanum
	jge mincla
	movl $1, mayumincla

matata:
	
	movl mayumincla, %ecx
	cmpl $0, mayumincla
	je conversion
	
follo:

	cmpl $0, codi
	je descii

dog:
	movl clanum, %ebx
	xorl franum, %ebx #hacer el xorl
	movl %ebx, cod

	cmpl $0, codi
	je yes
	
	
	
	cmpl $0, mayuminfra
	je ay
	addl $97, %ebx
yes:
	
	movl %ebx, cod

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

minfra:
	movl $0, mayuminfra
	jmp hakuna

mincla:

	movl $0, mayumincla
	jmp matata

conversion:
	
	
	movl clanum, %ecx
	subl $32, %ecx
	movl %ecx, clanum
	jmp follo

fixation:
	
	movl clanum, %ecx
	subl $32, %ecx
	movl %ecx, clanum
	jmp follo
	
ay:
	addl $65, %ebx
	jmp yes	

descii:
	cmpl $1, mayuminfra
	je yeah
	movl franum, %ecx
	subl $65, %ecx
	movl %ecx, franum
	
	jmp dog

yeah:	
	movl franum, %ecx
	subl $97, %ecx
	movl %ecx, franum
	jmp dog	
	
