.text
.eqv sbrk_stack_size 4
.eqv sbrk_ra 0
sbrk:
	addi $sp, $sp, -sbrk_stack_size
	sw $ra, sbrk_ra($sp)
	
	li $v0, 9
	syscall
	
	lw $ra, sbrk_ra($sp)
	addi $sp, $sp, sbrk_stack_size
	jr $ra
	
.text 
.eqv fr_ra -4
.eqv fr_n 0
.eqv fr_stack_size 8
factorial_recursive:
	# store
	# n = $s0
	addi $sp, $sp, -fr_stack_size
	sw $ra, fr_ra($sp)
	sw $s0, fr_n($sp)
	move $s0, $a0
	
	fr_begin_if:
		bgt $s0, 1, fr_end_if # n > 1
		# restore
		lw $s0, fr_n($sp)
		addi $sp, $sp, fr_stack_size
		li $v0, 1
		jr $ra
	fr_end_if:
	# result = n * factorial_recursive(n - 1)
	addi $a0, $s0, -1	# n = n  - 1
	jal factorial_recursive
	mul $v0, $s0, $v0  	
	
	# restore
	lw $s0, fr_n($sp)
	lw $ra, fr_ra($sp)
	addi $sp, $sp, fr_stack_size
	jr $ra

.text
is_prime:
	# n = a0
	li $t0, 2		# i = 2
	is_prime_begin_for:
		bge $t0, $a0, is_prime_end_for	# if  i >= n
	
		div $a0, $t0
		mfhi $t1		# t1 = n % i
		
		is_prime_begin_if:
			bne $t1, 0, is_prime_end_if # t1 != 0
			# if (t1 == 0) return 0
			li $v0, 0
			jr $ra
		is_prime_end_if:	
	add $t0, $t0, 1	# i = i + 1
	b is_prime_begin_for
is_prime_end_for:
	# return 1
	li $v0, 1
	jr $ra
		
.text
factorial: 
	li $t0, 2		# i = 2, a0 = n
	li $v0, 1	 	# result = 1
	factorial_for_begin:
		bgt $t0, $a0, factorial_for_end	# i > n
		mul $v0, $v0, $t0		# result = result * i
		add $t0, $t0, 1
		b factorial_for_begin
	factorial_for_end:
	jr $ra
	
.text	
exit: 
	li $v0, 10
	syscall
	jr $ra

.text
print_string:
	li $v0, 4
	syscall
	jr $ra
	
.text
print_new_line:
	li $v0, 4
	la $a0, __PNL_new_line
	syscall
	jr $ra
	
.text
print_int:
	li $v0, 4
	syscall
	move $a0, $a1
	li $v0, 1
	syscall
	jr $ra
.text
read_int:
	li $v0, 5
	syscall
	jr $ra
	
.data
	__PNL_new_line:	.asciiz "\n"
