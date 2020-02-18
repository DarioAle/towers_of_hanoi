#/*
# *  towers_of_hanoi.asm
# *
# *  Created on: 14/02/2020
# *
# *  Authors: Mariana Chávez Medina
# *           Darío Arias Muñoz
# *  Description:
#    This program receives the number of disks and simulates the moves from the 
#    Towers of Hanoi problem in addresses 0x10010000, 0x10010020, 0x10010040
#    Just another comment

.data
STACK_A: .word 0,0,0,0,0,0,0,0
STACK_B: .word 0,0,0,0,0,0,0,0
STACK_C: .word 0,0,0,0,0,0,0,0

PTR_A:   .word 0
TOP_A:	 .word 0,0,0,0,0,0,0,

PTR_B:	 .word 0
TOP_B:	 .word 0,0,0,0,0,0,0,

PTR_C:	 .word 0
TOP_C:	 .word 0

.text

Main:		
		addi $s0, $zero, 3	# Input number of disks
		
		# Fill initial addresses of the stack
		
		lui $s1, 0x1001		# Loading Address Peg A
		lui $s2, 0x1001		# Loading Address Peg B
		ori $s2, 0x0020
		lui $s3, 0x1001		# Loading Address Peg C
		ori $s3, 0x0040
		
		# Loading pointers to the base of the stack
		lui $t0, 0x1001		
		ori $t0, 0x0060		
		sw  $s1,($t0)		# Writing in address 0x10010060 pointer of the stack A
		
		lui $t0, 0x1001
		ori $t0, 0x0080
		sw  $s2, ($t0)		# Writing in address 0x10010080 pointer of the stack B
		
		lui $t0, 0x1001		
		ori $t0, 0x00a0
		sw  $s3, ($t0)		# Writing in address 0x100100a0 poiner of the stack C
		
		# Loading pointers to the tops of the stack
		
		lui $t0, 0x1001		
		ori $t0, 0x0064
		addi $t1, $s1, -4		
		sw  $t1,($t0)		# Writing in address 0x10010064 poiner of the top stack a
		
		lui $t0, 0x1001
		ori $t0, 0x0084
		addi $t1, $s2, -4
		sw  $t1, ($t0)		# Writing in address 0x10010084 poiner of the top stack b
		
		lui $t0, 0x1001		
		ori $t0, 0x00a4
		addi $t1, $s3, -4
		sw  $t1, ($t0)		# Writing in address 0x100100a4 poiner of the top stack c
		
		# Filling the stack with initial values
		and $t0, $t0, $zero	# Initialize t0 with zero as counter
		and $t1, $t1, $zero	# Initialize t1 with 1
		add $t0, $t0, $s0	# Set value of couner to be number of disks
FOR:		
		lw $t1, TOP_A		# Retrieve current pointer to top a 
		addi $t1, $t1, 4	# updated with new top
		sw $t1, TOP_A		# Store updated value
		
		sw $t0, ($t1)		# Store in the pointed value by top value of disk
		addi $t0, $t0, -1	# Decrement counter
		bne  $t0, $zero, FOR	# If counter is not zero iterate
		
		add $a0, $a0, $s0	# Set argument to number of disks
		lui $a1, 0x1001		# Set argument to pointer to A
		ori $a1, 0x060
		lui $a2, 0x1001		# Set argument to pointer to B
		ori $a2, 0x0a0
		lui $a3, 0x1001		# Set argument to pointer to C
		ori $a3, 0x0080
		
		# Detonating recursion
		jal MOVE
		j EXIT

		
MOVE:		
		beq $a0, $zero, ELSE		# BASE CASE if n == 0 exit function, 
		# Make space in the stack for the current to prepare for
		# the recursive call
		# Execution context
		addi $sp, $sp, -20	
					
		sw $ra 16($sp)		# Bottom of the stack return address		
		sw $a0, 12($sp)		
		sw $a3, 8($sp)
		sw $a2, 4($sp)
		sw $a1, ($sp)		# top of the stack ptr A
		
		addi $a0, $a0, -1
		# now n-1 target is the auxiliary peg
		
		# swap auziliary and targe
		and $t7, $t7, $zero
		add $t7, $t7, $a2	# Save in temp target
		
		and $a2, $a2, $zero		
		add $a2, $a2, $a3	# assign to target, auxiliary
		
		and $a3, $a3, $zero	
		add $a3, $a3, $t7	# assign to auxiliary, target
		
		jal MOVE
		
		# Retrieve all the execution context from the stack 
		# From the previous call
		lw $ra 16($sp)		# Bottom of the stack return address		
		lw $a0, 12($sp)		
		lw $a3, 8($sp)
		lw $a2, 4($sp)
		lw $a1, ($sp)		# top of the stack ptr A
		addi $sp, $sp, 20
		
	# ---------- Read from source -------# 	
		# From the stack a received, add four to access its
		# top that it's contiguous in memory
		addi $t6, $a1, 4	
		lw $t5,  ($t6)		# access that value to know the current position of top
		lw $t4, ($t5)		# Access pointed disk value by top
		sw $zero, ($t5)		# Write a zero in the position pointed by top
		addi $t5, $t5, -4	# Decrement address pointing to top
		sw $t5, ($t6)		# Update value of address pointent by top
		
	# ----------- Write on target --------- #
		and $t6, $t6, $zero	# Reset value of $t6
		# From the stack a received, add four to access its
		# top that it's contiguous in memory
		addi $t6, $a2, 4	
		lw $t5, ($t6)		# Access that value to know the current position of top
		addi $t5, $t5, 4	# Increment the top pointer
		sw $t5, ($t6)		# Update value of address pointent by top
		sw $t4, ($t5) 		# Write value of new top
		
	# ----------------- Next call ----------#	
		# Make space in the stack for the current
		# Execution context to prepare fot he next call
		addi $sp, $sp, -20	
					
		sw $ra 16($sp)		# Bottom of the stack return address		
		sw $a0, 12($sp)		
		sw $a3, 8($sp)
		sw $a2, 4($sp)
		sw $a1, ($sp)		# top of the stack ptr A

		# Prepare arguments for next call
		# now n-1 target is the auxiliary peg
		addi $a0, $a0, -1
		
		# swap auziliary and target
		and $t7, $t7, $zero
		add $t7, $t7, $a1	# Save in temp source
		
		and $a1, $a1, $zero		
		add $a1, $a1, $a3	# assign to target, auxiliary
		
		and $a3, $a3, $zero	
		add $a3, $a3, $t7	# assign to auxiliary, target
		
		jal MOVE
		
		# Retrieve all the execution context from the stack 
		# From the previous call
		lw $ra 16($sp)		# Bottom of the stack return address		
		lw $a0, 12($sp)		
		lw $a3, 8($sp)
		lw $a2, 4($sp)
		lw $a1, ($sp)		# top of the stack ptr A
		addi $sp, $sp, 20
ELSE:		
		jr $ra
		
EXIT:
