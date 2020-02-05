.global _start

.text
_start:
	li $a0, string
	
# prepares stack for pushing and popping
reversestring:
	li    $s0, 0        # i = 0, indicates bottom of stack
	addiu $sp, $sp, -4  # decrement for $s0 
	sw    $s0, 0($sp)   # store $s0, address of word index, into stack
	add   $t0, $a0, $s0 # $t0 = address of string + index, string[i]
	
pushchars:
	lbu $s0, 0($t0)      # string[i] into $s0
	
	beq $s0, $zero, endofstring
	
	addiu $sp, $sp, -4	 # decrement(more space) for more bytes in string
	sw    $s0, 0($sp)	 # save word in stack
	
	addiu $t0, $t0, 1    # increment string + index address
	j pushchars
	
endofstring: 
	add $t0, $a0, $s0    # reset to string[i]
	j popchars
	
popchars:	
	lw    $s0, 0($sp)        # restore saved $s0
	addiu $sp, $sp, 4        # pop into memory from stack
	
	beq   $s0, $zero, finish # pop until empty
	
	sb    $s0, 0($t0)		 # $s0 = string[i + n]
	
	addiu $t0, $t0, 1		 # increment index address
	j popchars
	
finish:
	li $v0, 4
	syscall
	
	li $v0,10
	syscall
	
.data
    string: .asciiz "Computing is Awesome!"