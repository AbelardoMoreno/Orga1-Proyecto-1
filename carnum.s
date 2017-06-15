.section .data

	alfa: .ascii  "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"

	minu: .ascii "a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"

.section .bss

.section .text

.globl carnum

carnum:
	pushl %ebp
	movl %esp, %ebp
	movl 8(%ebp), %esi #esi arreglo
	movl 12(%ebp), %edi #edi indice
	xorl %ebx,%ebx
	
fun:	movb (%esi,%edi,1),%cl
	movb alfa(,%ebx,1), %al
	cmpb %cl, %al
	je hola
	incl %ebx
	cmpl $52, %ebx
	jg algo
	jmp fun
algo:	movl $47, %eax   #caracter / que es no econtrado
	jmp fin
hola:	
	cmpl $25,%ebx
	jg minus
	addl $65,%ebx #suma para que de el ascii del char mayuscula
	movl %ebx,%eax
fin:	leave
	ret
	
minus:	#suma para que de el ascii del char minuscula
	addl $71,%ebx
	movl %ebx,%eax
	jmp fin
	
	
	
	