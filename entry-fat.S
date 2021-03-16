.text
.globl __start

LOAD_ADDR = 0x801FC100

# s0 = realstart physical address
# s1 = A table address

__start:
	# Restore stack pointer
	li $sp, 0x801FFF00

	# Disable interrupts
	mfc0 $t0, $12
	li $t1, 0xFFFFFBFE
	and $t0, $t1
	mtc0 $t0, $12

	# Call ourselves to get the current program counter in $ra
	bal realstart

realstart:
	# Calculate start address
	addi $t0, $ra, tonyhax_start - realstart

	# Load destination address
	li $t1, LOAD_ADDR

	# Calculate end address
	addi $t2, $ra, tonyhax_end - realstart

	# Copy to target address
copynext:
	lw $t3, 0($t0)
	sw $t3, 0($t1)

	addi $t0, 4
	addi $t1, 4
	bne $t0, $t2, copynext

	# Jump to it!
	li $s0, LOAD_ADDR
	jr $s0

tonyhax_start:

.align 4
.incbin "secondary.bin"
.align 4

tonyhax_end:
