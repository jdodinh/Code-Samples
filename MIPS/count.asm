#studentName:
#studentID:

# This MIPS program should count the occurence of a word in a text block using MMIO

.data
#any any data you need be after this line 


title:	.asciiz	"\nWordCount"
prompt1:	.asciiz	"\nEnter the text segment:\n"
prompt2:	.asciiz	"\nEnter the search word:\n"
newline:	.asciiz "\n"
textsegment: 	.space	601
searchword:	.space	601
The_word:	.asciiz "\nThe word '"
occurred:	.asciiz	"' occurred "
times:		.asciiz " time(s).\npress ’'e'’ to enter another segment of text or ’'q'’ to quit."
	.text
	.globl main

main:	# all subroutines you create must come below "main"
	la	$a1, textsegment	#the address of the buffer that we will write to using the syscall instruction
	add 	$t3, $zero, $zero	#a counter which we will use to keep track of the length of the text segment, as well as byte location
	
	li	$v0, 4
	la	$a0, title
	#jal	write1
	syscall				#printing the name of the program
	
	add 	$t3, $zero, $zero
	li	$v0, 4
	la	$a0, prompt1
	syscall
	#jal	write1
									#asking the user to enter the text block
	
	add 	$t3, $zero, $zero
	
	jal	Read
	
	add 	$t3, $zero, $zero
	
	li	$v0, 4
	la	$a0, textsegment
	syscall
	#jal	write1
	
	la	$a1, searchword
	add 	$t3, $zero, $zero
	
	li	$v0, 4
	la	$a0, prompt2
	syscall
	#jal	write1				#asking the user to enter the search word
	
	add 	$t3, $zero, $zero
	
	jal	Read
	
	move	$s1, $t3		#$s1 will contain the length of the search word
	
	add 	$t3, $zero, $zero
	
	li	$v0, 4
	la	$a0, searchword
	#jal	write1
	syscall				#printing the searchword to the console
	
	add 	$t3, $zero, $zero
	li	$v0, 4
	la	$a0, newline
	#jal	write1
	syscall
	
	jal	wordsearch
	
	move	$s2, $t7
	
	add 	$t3, $zero, $zero
	li	$v0, 4
	la	$a0, The_word
	#jal	write1
	syscall
	
	add 	$t3, $zero, $zero
	li	$v0, 4
	la	$a0, searchword
	#jal	write1
	syscall	
	
	add 	$t3, $zero, $zero
	li	$v0, 4
	la	$a0, occurred
	#jal	write1
	syscall
	
	
	li	$v0, 1
	#addi	$s2, $s2, 48
	move	$a0, $s2
	#jal 	writeint
	
	syscall
	
	add 	$t3, $zero, $zero
	li	$v0, 4
	la	$a0, times
	#jal	write1
	syscall
	
	jal	Read2
	
	li	$v0, 10
	syscall
	
	
Read:	lui	$t0, 0xffff		#address of the keybord register
waitloop1:
	lw	$t1, 0($t0)
	andi	$t1, $t1, 0x0001
	beq	$t1, $zero, waitloop1
	lw	$v0, 4($t0)
	bgt	$t3, 600, jumpback
	beq	$v0, 10, jumpback
	add	$t4, $a1, $t3
	sb	$v0, ($t4)
	addi	$t3, $t3, 1
	
	j	waitloop1
	
Read2:	lui	$t0, 0xffff		#address of the keybord register
waitloop2:
	lw	$t1, 0($t0)
	andi	$t1, $t1, 0x0001
	beq	$t1, $zero, waitloop2
	lw	$v0, 4($t0)
	beq	$v0, 101, main
	beq	$v0, 113, jumpback
	
	j	waitloop2
	
	
write1:	lui	$t0, 0xffff
waitloop:
	#lw	$t1, 8($t0)
	#andi	$t1, $t1, 0x0001
	#beq	$t1, $zero, waitloop
	add	$t2, $a0, $t3
	lb	$v0, ($t2)
	beq	$v0, $zero, jumpback
	
	sb	$v0, 12($t0)
	addi	$t3, $t3, 1
		
	j	waitloop
	
writeint:
	lui	$t0, 0xffff
wait:	sb	$a0, 12($t0)
	j	jumpback

wordsearch:
	la	$a1, textsegment
	la	$a2, searchword
	add	$t1, $zero, $zero	#initializing counter for the text segment
	add	$t2, $zero, $zero	#initializing counter for the search word
	add	$t7, $zero, $zero	#initializing the counter for word occurrences
	
searchloop:
	add	$t3, $a1, $t1
	add	$t4, $a2, $t2		#getting the addresses of the bytes in the text segment and the string
	lb	$t5, ($t3) 
	lb	$t6, ($t4)		#storing the bytes in their respective registers
	bne	$t5, $t6, failedsearch	#if the letters don't match, we call it a failed search, and jump to the label
	addi	$t1, $t1, 1
	addi	$t2, $t2, 1
	bge 	$t2, $s1, findmatch	#if letters match and the word is long enough
	
	
	j	searchloop
	
failedsearch:
	beq	$t5, $zero, jumpback  	#check for null termination
	addi	$t1, $t1, 1		#in the event of a failed search the text segment counter still inrements
	add	$t2, $zero, $zero	#the address of the search word goes back to zero
	j	searchloop		#jump back to the searchloop
	
findmatch:
	add	$t2, $zero, $zero	#reset searchword counter
	add	$t3, $a1, $t1		#get the address of the character after the end of the word
	lb	$t5, ($t3)		#get the character after the end of the word
	bge	$t5, 48, searchloop	#it must be a space
	subi	$t3, $t3, 1
	sub	$t3, $t3, $s1		#get the address of the byte before the word starts
	lb	$t5, ($t3)		#get the character before the beginning of the word
	bge	$t5, 48, searchloop	#it must be a space
	addi	$t7, $t7, 1
	
	j	searchloop
	
terminateString:
	add	$t4, $a1, $t3
	#sb	$zero, ($t4)	
	jr	$ra
	

jumpback:
	jr	$ra
	
	
