.section .data

.section .bss
var: .space 4
var1: .space 1
var2: .space 1
.section .text
.globl contar
contar:
	pushl %ebp
	movl %esp,%ebp
	movl 8(%esp), %esi #es un arreglo :)
	xorl %ebx,%ebx
	xorl %eax,%eax

for:	
	movb (%esi,%ebx,1), %cl
	xorl %edi,%edi
	movb %cl,var
	incl %ebx
	cmpl $512,%ebx
	jge afin

	movb %cl, var
	pushl %ebx

	cmpb $65,var
	je for
	cmpb $66,var
	je for
	cmpb $67,var
	je for
	cmpb $68,var
	je for
	cmpb $69,var
	je for
	cmpb $70,var
	je for
	cmpb $71,var
	je for
	cmpb $72,var
	je for
	cmpb $73,var
	je for
	cmpb $74,var
	je for
	cmpb $75,var
	je for
	cmpb $76,var
	je for
	cmpb $77,var
	je for
	cmpb $78,var
	je for
	cmpb $79,var
	je for
	cmpb $80,var
	je for
	cmpb $81,var
	je for
	cmpb $82,var
	je for
	cmpb $83,var
	je for
	cmpb $84,var
	je for
	cmpb $85,var
	je for
	cmpb $86,var
	je for
	cmpb $87,var
	je for
	cmpb $88,var
	je for
	cmpb $89,var
	je for
	cmpb $90,var
	je for
	cmpb $97,var
	je for
	cmpb $98,var
	je for
	cmpb $99,var
	je for
	cmpb $100,var
	je for
	cmpb $101,var
	je for
	cmpb $102,var
	je for
	cmpb $103,var
	je for
	cmpb $104,var
	je for
	cmpb $105,var
	je for
	cmpb $106,var
	je for
	cmpb $107,var
	je for
	cmpb $108,var
	je for
	cmpb $109,var
	je for
	cmpb $110,var
	je for
	cmpb $111,var
	je for
	cmpb $112,var
	je for
	cmpb $113,var
	je for
	cmpb $114,var
	je for
	cmpb $115,var
	je for
	cmpb $116,var
	je for
	cmpb $117,var
	je for
	cmpb $118,var
	je for
	cmpb $119,var
	je for
	cmpb $120,var
	je for
	cmpb $121,var
	je for
	cmpb $122,var
	je for		
	cmpb $47,var
	je sapo
	jmp afin
	
sapo:	
	cmpl $1,%ebx
	je afin
	cmpl $512,%ebx
	jle fin

afin:	movl $1,%eax
	
fin:	
	movl %ebx,%edi
	leave
	ret

