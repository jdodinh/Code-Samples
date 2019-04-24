#studentName:
#studentID:

# This MIPS program should sort a set of numbers using the quicksort algorithm
# The program should use MMIO

.data
#any any data you need be after this line 
title:		.asciiz	"Welcome to QuickSort\nStart entering values into the MMIO\n"
sortedmessage:	.asciiz "\nThe sorted array is: "
newline:	.asciiz "\n"
space:		.asciiz " "
reinitialized:	.asciiz "The array is re-initialized\n"

buffer:		.space 	2048
array:		.word	2048
newarray:	.space	2048
newbuff:	.space 	2048




	.text
	.globl main

main:	# all subroutines you create must come below "main"
	
	add	$t3, $zero, $zero
	la	$a0, title
	jal	writeMMIO
	addi	$sp, $sp, -32
main2:
	la	$a1, buffer
	la	$a2, array
	sw	$a1, ($sp)		#0($sp) address of the buffer 
	sw	$a2, 4($sp)		#4($sp) address of the array

	add	$t2, $zero, $zero	
	add 	$t3, $zero, $zero	#2 counter variables 
	add	$s3, $zero, $zero
	
	jal	Read			#reading the values from user input into the MMIO keyboard simulator
	
	sw	$t3, 12($sp)		#$t3 will be the length of the buffer
	add 	$t3, $zero, $zero	#reseting the counter
	
	la	$a0, buffer
	#jal	writeMMIO
					#printing the buffer
	
	add 	$t3, $zero, $zero
	
	la	$a0, newline
	jal	writeMMIO
	
	add	$t2, $zero, $zero	
	add 	$t3, $zero, $zero
program:
	la	$a1, buffer
	la	$a2, array
	add	$s3, $zero, $zero
	add	$t2, $zero, $zero	
	add 	$t3, $zero, $zero

	jal	fillarray		#filling the array with integers
	
	sw	$s3, 8($sp)		

	add	$t2, $zero, $zero	
	add 	$t3, $zero, $zero

	
	la	$a0, array
	add	$a1, $zero, $zero
	lw	$a2, 8($sp)
	addi	$a2, $a2, -1
	jal	quicksort
	
	add	$t2, $zero, $zero	
	add 	$t3, $zero, $zero
	
	add	$t2, $zero, $zero	
	add 	$t3, $zero, $zero
	
	add	$t2, $zero, $zero	
	add 	$t3, $zero, $zero
	
	jal	arraytobuff		#array to buffer routine
	
	li	$v0, 4
	la	$a0, newbuff
	syscall

	add	$t2, $zero, $zero	
	add 	$t3, $zero, $zero
	
	la	$a0, sortedmessage
	jal	writeMMIO
	
	
	add	$t2, $zero, $zero	
	add 	$t3, $zero, $zero
	
	
	la	$a0, newbuff
					#trying to print the new buffer
	jal	writeMMIO
	
	add	$t2, $zero, $zero	
	add 	$t3, $zero, $zero
	la	$a0, newline
	jal	writeMMIO
	
	add	$t2, $zero, $zero	
	add 	$t3, $zero, $zero
	
	la	$a1, buffer		#loading address of the buffer
	lw	$s4, 12($sp)
	add	$a1, $a1, $s4
	li	$t1, 32
	sb	$t1, ($a1) 
	addi	$a1, $a1, 1
	
	add	$t2, $zero, $zero	
	add 	$t3, $zero, $zero	#2 counter variables 
	add	$s3, $zero, $zero
	
	jal	Read
	lw	$t4, 12($sp)
	add	$t4, $t3, $t4
	addi	$t4, $t4, 1
	sw	$t4, 12($sp)
	
	add	$t2, $zero, $zero	
	add 	$t3, $zero, $zero
	
	j	program
	
	li	$v0, 1
	lw	$a0, 8($sp)
	syscall				#printing the length of the array
	
	lw	$s3, 8($sp)
	
	addi	$sp, $sp, 32
	
	j	end
	
#############################################################################################
quicksort:
	
	
	
	subi	$sp, $sp, 20
	sw	$ra, ($sp)		#storing return address
	sw	$a0, 4($sp)		#storring array address
	sw	$a1, 8($sp)		#storing low index
	sw	$a2, 12($sp)		#storing high index
	ble	$a2, $a1, done		#if hi<=low return
	
	lw	$a0, 4($sp)
	lw	$a1, 8($sp)
	lw	$a2, 12($sp)
	
	jal	partition
	add	$t9, $v0, $zero
	lw	$a0, 4($sp)
	lw	$a1, 8($sp)
	addi	$a2, $t9, -1
	jal	quicksort
	lw	$a0, 4($sp)
	lw	$a1, 16($sp)
	lw	$a2, 12($sp)
	addi	$a1, $t9, 1	#new value for low
	jal	quicksort
done:
	lw	$ra, ($sp)
	lw	$a0, 4($sp)
	lw	$a1, 8($sp)
	lw	$a2, 12($sp)
	addi	$sp, $sp, 20
	jr	$ra
	
partition:
	#	$a0 = array
	#	$a1 = low (index)
	#	$a2 = hi (index)
	#	$t0 = pivot
	#	$t1 = p_pos
	#	$t2 = i (counter)
	#	$t3 = address of comparison variable
	#	$t4 = 
	# 	$t5 = counter
	addi	$sp, $sp, -16
	sw	$a0, ($sp)
	sw	$a1, 4($sp)
	sw	$a2, 8($sp)
	sw	$ra, 12($sp)
	
	add	$t1, $a1, $zero		#loading original pivot position $t1 = p_pos = low
	
	sll	$t3, $t1, 2	
	add	$t3, $t3, $a0		#getting the address of the pivot
	
	lw	$t0, ($t3)		#getting the value of the pivot
	
	addi	$t2, $a1, 1		#setting the counter to be low+1
	
partitionloop:
	
	lw	$a2, 8($sp)
	bgt	$t2, $a2, endpartition
	lw	$a0, ($sp)
	sll	$t3, $t2, 2		
	add	$t3, $a0, $t3		#getting the address of the comparison variable
	lw	$t4, ($t3)
	bge	$t4, $t0, skip
	addi	$t1, $t1, 1
	lw	$a0, ($sp)
	add	$a1, $t1, $zero
	add	$a2, $t2, $zero
	jal	swap
	
skip:
	addi	$t2, $t2, 1
	j	partitionloop

endpartition:
	
	lw	$a0, ($sp)
	lw	$a1, 4($sp)
	add	$a2, $t1, $zero
	jal	swap
	
	lw	$a0, ($sp)
	lw	$a1, 4($sp)
	lw	$a2, 8($sp) 
	lw	$ra, 12($sp)
	addi	$sp, $sp, 16
	add	$v0, $t1, $zero
	jr	$ra
	
swap:
#$a0 = array address
#$a1 = i
#$a2 = j
	sll	$a1, $a1, 2
	sll	$a2, $a2, 2
	add	$t4, $a0, $a1
	add	$t6, $a0, $a2
	lw	$t7, ($t4)
	lw	$t8, ($t6)
	sw	$t7, ($t6)
	sw	$t8, ($t4)

	jr	$ra

#############################################################################################
Read:	lui	$t0, 0xffff		#address of the keybord register
waitloop1:
	lw	$t1, 0($t0)
	andi	$t1, $t1, 0x0001
	beq	$t1, $zero, waitloop1
	lw	$v0, 4($t0)
	beq	$v0, 99, clear		#if the user enters 'c' we jumpback
	beq	$v0, 115, jumpback	#if the user enters 's' we jumpback (eventually sort)
	beq	$v0, 113, end		#if the user enters 'q' we jumpback
	beq	$v0, 32, cont
	blt	$v0, 48, waitloop1	
	bgt	$v0, 57, waitloop1
cont:
	sb	$v0, 12($t0)
	add	$t4, $a1, $t3
	sb	$v0, ($t4)
	addi	$t3, $t3, 1
	
	j	waitloop1
	
writeMMIO:
	lui	$t0, 0xffff
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
#################################################
fillarray:
	add	$t4, $a1, $t2		#address of the first element in the buffer
	add	$t5, $a2, $t3		#address of the element in the array
	lb	$s0, ($t4)
	lb	$s1, 1($t4)
	bge	$s1, 48, eval		#branch if second value is greater than 48, meaning it's a 2 digit number
	beq	$s0, $zero, jumpback 
	
	addi	$s0, $s0, -48
	andi	$s0, $s0, 0x0FF
	
	sw	$s0, ($t5)
	
	addi	$t2, $t2, 2
	addi	$t3, $t3, 4
	addi	$s3, $s3, 1
	
	j	fillarray
	

eval:
	addi	$s0, $s0, -48
	addi	$s0, $s0, -48
	
	andi	$s0, $s0, 0x0F
	andi	$s1, $s1, 0x0F
	
	mul	$s0, $s0, 10
	add	$s0, $s0, $s1
	sw	$s0, ($t5)
	
	addi	$t2, $t2, 3
	addi	$t3, $t3, 4
	addi	$s3, $s3, 1
	
	j	fillarray
#################################################
arraytobuff:
	la	$a1, newbuff		#buffer that we will write to
	la	$a2, array		#
	add	$t2, $zero, $zero
	add	$t3, $zero, $zero
	lw	$s3, 8($sp)
	
convloop:
	beq	$s3, $zero, jumpback
	add	$t4, $a1, $t2		#$t4 contains the address to a pointer in the new buffer
	add	$t5, $a2, $t3		#$t5 contains the address to a pointer in the array
	
	lw	$s1, ($t5)		#fetching the integer in the array
	andi	$s1, $s1, 0x0FF
	addi	$t0, $zero, 10
	div	$s1, $t0
	mflo	$s1			#$s1 will have the quotient 
	mfhi	$s2			#$s2 will have the remainder
	andi	$s1, $s1, 0x0F
	andi	$s2, $s2, 0x0F
	bnez	$s1, twodigits
	addi	$s2, $s2, 48
	sb	$s2, ($t4)
	addi	$t0, $zero, 32
	sb	$t0, 1($t4)
	
	addi	$t2, $t2, 2
	addi	$t3, $t3, 4
	addi	$s3, $s3, -1
	
	la	$a1, newbuff		#buffer that we will write to
	la	$a2, array
	
	j	convloop
	

twodigits:
	addi	$s1, $s1, 48
	addi	$s2, $s2, 48
	addi	$t0, $zero, 32
	
	sb	$s1, ($t4)
	sb	$s2, 1($t4)
	sb	$t0, 2($t4)
	
	addi	$t2, $t2, 3
	addi	$t3, $t3, 4
	addi	$s3, $s3, -1
	
	la	$a1, newbuff		#buffer that we will write to
	la	$a2, array
	
	j	convloop
	
#################################################	

clear:
	la	$a1, buffer
	la	$a2, array
	la	$a3, newbuff
	add	$t2, $zero, $zero
	add	$t3, $zero, $zero
	lw	$t6, 8($sp)
	
clearloop:
	beq	$t6, $zero, endclear
	add	$t4, $a1, $t2
	add	$t5, $a2, $t3
	add	$t7, $a3, $t2
	sb	$zero, ($t4)
	sb	$zero, 1($t4)
	sb	$zero, 2($t4)
	
	sb	$zero, ($t7)
	sb	$zero, 1($t7)
	sb	$zero, 2($t7)
	
	sw	$zero, ($t5)
	
	addi	$t2, $t2, 3
	addi	$t3, $t3, 4
	
	subi	$t6, $t6, 1
	
	j clearloop

endclear:
	

	add	$t2, $zero, $zero	
	add 	$t3, $zero, $zero
	sw	$zero, 8($sp)
	la	$a0, reinitialized
	jal	writeMMIO
	
	sw	$zero, 8($sp)
	
	add	$t2, $zero, $zero	
	add 	$t3, $zero, $zero
	
	j	main2
#################################################

jumpback:
	jr	$ra
	
printarray:
	beqz	$s3, jumpback
	add	$t5, $a2, $t3
	
	lw	$a0, ($t5) 
	#beq	$a0, $zero, jumpback
	
	li	$v0, 1
	syscall
	
	li	$v0, 4
	la	$a0, space
	syscall
	
	addi	$t3, $t3, 4
	addi	$s3, $s3, -1
	
	j 	printarray
	
malloc:
	li 	$v0, 9
	syscall
	jr	$ra

end:
	addi	$sp, $sp, 32
	li	$v0, 10
	syscall
	
	


