.section .data
	
	alfa: .ascii  "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"
	borrador: .asciz "\0"
	
.section .bss
	cuantos: .space 4
	dir:	.space 4
	indice: .space 4
	arr2: .space 1024 
	cantidad2: .space 4
	despla: .space 4
	cod: .space 4
	indi: .space 4
	mayumin: .space 4
	arrcod: .space 1024 /**ARREGLO DONDE SE VA A GUARDAR LO CODIFICADO**/
.section .text

.globl hacersustitucion

hacersustitucion:

	pushl %ebp
	movl %esp, %ebp
	movl 8(%esp), %edi /** ARREGLO*/
	movl 12(%esp), %esi/*; CUANTAS POSICONES A DESPLAZAR*/
	movl 16(%esp), %edx/*; HACIA DONDE SE DESPLAZA*/
	movl 20(%esp), %eax/*; CUANTOS CARACTERES TIENE EL ARREGLO -1*/
	
	movl %edi,arr2
	movl %edx,dir
	cmpl $50,dir
	je negado

continue:
	movl borrador, %edx
	movl %edx, arrcod
	movl %eax,cuantos
	movl %esi, despla

	movl $0, indi
	
for:
	
	pushl indi
	pushl arr2
	call carnum
	addl $8,%esp
	
	movl %eax, cod
	
	cmpl $97,cod
	jge min
	movl $0, mayumin
keep:	
	movl cod, %edx
	addl despla, %edx
	movl %edx, cod

	cmpl $1, mayumin
	je checkmin
	cmpl $65, cod
        jl fix
        cmpl $90, cod
        jg fix
	
sigue:
	
	pushl cod
	call numcar
	addl $4, %esp

	movl %eax, cod

	movl cod, %edx
	movl indi, %ebx 

	movb alfa(,%edx,1), %cl
	movb %cl, arrcod(,%ebx,1)


	incl indi
	movl indi, %edx
 	cmpl cuantos, %edx
	je fin
	jmp for
fin:
	
	leal arrcod, %eax
	leave
	ret

negado:
	imull $-1,%esi #si se desplaza a la izqeurda le cambia el signo pues hay q restar
	jmp continue

fix: 
	cmpl $50, dir
	je izq
	movl cod, %edx
	subl $26, %edx
	movl %edx, cod
	jmp sigue

izq:
	movl cod, %edx
	addl $26, %edx
	movl %edx, cod
	jmp sigue

min:
	movl $1, mayumin
	jmp keep

checkmin:

	cmpl $97, cod
	jl fix
	cmpl $122, cod
	jg fix
	jmp sigue

