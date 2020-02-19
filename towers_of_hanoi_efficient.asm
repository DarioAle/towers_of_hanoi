#/*
# *  towers_of_hanoi.asm
# *
# *  Created on: 14/02/2020
# *
# *  Authors: Mariana Chavez Medina
# *           Dario Arias Munoz
# *  Description:
#    This program receives the number of disks and simulates the moves from the 
#    Towers of Hanoi problem in addresses 0x10010000, 0x10010020, 0x10010040


.text

Main:		
		addi $s0, $zero, 3	# Input number of disks
		
		# Loading addresses for the stacks base minus 4 bytes
		addi $a1, $zero, 0x1000	# Loading base address upper half for Peg A
		sll $a1, $a1 16		# Shifting to the left 16 positions
		ori $a1, $a1, 0xFFFC	# Or with the base address
		addi $a2, $a1, 0x0040	# Loading Address Peg C
		addi $a3, $a1, 0x0020	# Loading Address Peg B
		
		addi $t9, $zero, 1	# Load register with 1, used in the base case comparison 
		
		
		# Filling the stack with initial values
		add $t0, $s0, $zero	# Start counter variable to the number of disks	
		
FOR:		addi $a1, $a1, 4	# increment top
		sw $t0, ($a1)		# store counter value in the top of the stack
		addi $t0, $t0, -1	# Decrement counter
		bne  $t0, $zero, FOR	# If counter is not zero iterate
		
		
		add $a0, $a0, $s0	# Set argument to number of disks
		jal SolveHanoiRecursive	# Start recursive solution
		j EXIT

		
SolveHanoiRecursive:
		
		bne $a0, $t9, ELSE	# BASE CASE if n == 1
		# Read from source
		lw $t5,  ($a1)		# Save value pointed by top
		sw $zero, ($a1)		# Write a zero in the position pointed by top in source
		addi $a1, $a1, -4	# Decrement address pointing to top
		# Write on target
		addi $a2, $a2, 4	# Increment the top pointer
		sw $t5, ($a2) 		# Write value of new top in target
		j END
ELSE:		
		addi $sp, $sp, -4	# Save space for $ra
		sw $ra ($sp)		# Bottom of the stack return address
		
		addi $a0, $a0, -1	# decrement size of disks
		# swap auxiliary and target
		add $t7, $a2, $zero	# Save in temp target
		add $a2, $a3, $zero	# assign to target, auxiliary
		add $a3, $t7, $zero	# assign to auxiliary, temp
		
		jal SolveHanoiRecursive # now we solve for n - 1 and swapped pegs
		
		# swap auxiliary and target to go back to the refernces originally made to this call
		add $t7, $a2, $zero	# Save in temp target
		add $a2, $a3, $zero	# assign to target, auxiliary
		add $a3, $t7, $zero	# assign to auxiliary, target
		
		
		# Read from source  	
		lw $t5,  ($a1)		# save the value pointed by top in source
		sw $zero, ($a1)		# Write a zero in the position pointed by top
		addi $a1, $a1, -4	# Decrement address pointing to top
		# Write on target
		addi $a2, $a2, 4	# Increment the top pointer
		sw $t5, ($a2) 		# Write value of new top


		addi $a0, $a0, -1	# decrement size of disks
		# swap auxiliary and source
		add $t7, $a1, $zero	# Save in temp source		
		add $a1, $a3, $zero	# assign to source, auxiliary
		add $a3, $t7, $zero	# assign to auxiliary, temp
		
		jal SolveHanoiRecursive # now we solve for n - 1 and swapped pegs
		
		# swap auxiliary and source to go back to the refernces originally made to this call
		add $t7, $a1, $zero	# Save in temp source		
		add $a1, $a3, $zero	# assign to source, auxiliary
		add $a3, $t7, $zero	# assign to auxiliary, temp
		
		lw $ra ($sp)		# Bottom of the stack return address		
		addi $sp, $sp, 4	# Update top in stack pointer
END:		
		addi $a0, $a0, 1
		jr $ra
		
EXIT:
