.section .data

	alfa: .ascii  "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"

	form2: .asciz "%d\n"
	
.section .bss

.section .text

.globl numcar

numcar:
	pushl %ebp
	movl %esp, %ebp
	movb 8(%ebp), %cl #esi numero a caracter
	xorl %ebx,%ebx
	xorl %edi,%edi #contador
	xorl %edx, %edx
	
	
fun:
	movb alfa(,%edx,1), %al
	cmp %cl, %al
	je hola
	
	
	incl %edx
	cmpl $52, %edx
	jg algo
	jmp fun
	
algo:	
	movl $52, %eax   #caracter / que es no encontrado
	jmp fin
hola:	
	movl %edx,%eax
	
fin:	leave
	ret
	
	
	
	
