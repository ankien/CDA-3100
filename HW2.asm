.global _start

.text
	_start:
		la $s0, m
		lw $s1, 0($s0) # load value at m
	
		la $s2, n
		lw $s3, 0($s2) # load value at n
	
		li $t0, 0 # message loop counter
		li $t1, 0 # number loop counter
		li $t2, 0 # number sum
	
	printMessageLoop:
		beq $t0, $s1, printNumberLoop
	
		la $a0, myString
		li $v0, 4
		syscall
	
		addi $t0, $t0, 1
		j printMessageLoop
	
	printNumberLoop:
		add $t2, $t2, $t1
	
		beq $t1, $s3, finish
	
		addi $t1, $t1, 1
		j printNumberLoop
	
	finish:
		add $a0, $t2, $zero 
		li $v0, 1
		syscall
	
		li $v0, 10
		syscall
     
.data
	m: .word 3
	n: .word 5
	myString: .asciiz "Hello UNF\n"