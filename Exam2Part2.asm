.global _start

.text
_start:
	li $t0, 0       # 0 - n counter for addloop
	li $t1, 0       # 0 - n counter for current denominator
	lwc1 $f12, zero # clear division result
	lwc1 $f4, one   # $f4.s = denominator
	lwc1 $f1, zero  # $f1.s = 0.0
	lwc1 $f2, one   # $f2.s = 1.0
	lwc1 $f3, two   # $f3.s = 2.0 
	
	j main

main:
	# scan integer from input into $v0
	li $v0, 5
	syscall
	
	# compute 1 + 1/2 + ... + 1/(2^n)
	j addloop
	
print:
	# put result into $f0.s(project req), then print out $f12.s
	add.s $f0, $f12, $f1
	li $v0, 2
	syscall
	
	j finish
	
addloop:
	# calculate denominator
	jal denominatorloop
	
	# divide 1.0 by denominator
	div.s $f5, $f2, $f4
	
	# add result of division into $f12.s
	add.s $f12, $f12, $f5
	
	beq $t0, $v0, print
	addi $t0, 1
	j addloop
	
denominatorloop:
	beq $t1, $t0, exit
	mul.s $f4, $f3, $f4
	addi $t1, 1
	j denominatorloop

exit:
	jr $ra
	
finish:
	li $v0, 10
	syscall
	
.data
	zero: .single 0.0
	 one: .single 1.0 
	 two: .single 2.0