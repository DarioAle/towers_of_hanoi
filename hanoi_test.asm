#/*
# *  towers_of_hanoi.am
# *
# *  Created on: 14/02/2020
# *      Authors: Mariana Chávez Medina
# *               Darío Arias Muñoz
# */

.data

.text  

Main:
	addi $s0, $zero, 0	# Index
	
	lui $s2, 0x1001		# Load Vector1 address
	li  $t1, 1
	li $s0, 256

FOR:	addi $s0, $s0, -1	# Set temporal variable t0 if index is less than 256
	sb   $t1, ($s2)
	addi $s2, $s2,  1	# Increment pointer to the next word address
	bne  $s0 , $zero, FOR	# if temporarl is not set continue, because i < 9
	j Exit			# Exit
	
Prod:	mul $v0, $a0, $a1	# Multiplication
	jr $ra

Exit:
