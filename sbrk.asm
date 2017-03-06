.text
main:
	li $a0, 4
	jal sbrk
	move $t0, $v0
	li $s0, 100
	sw $s0, 0($t0)
	lw $a1, 0($t0)
	la $a0, result
	jal print_int

	jal exit
.text

.data
	prompt: 	.asciiz "Nhap n = "
	result: 		.asciiz "Ket qua: "
.include "utils.asm"
