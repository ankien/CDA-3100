.global _start

.text
_start:
	lwc1 $f2, two
	lwc1 $f3, one
	lwc1 $f4, longnumber
	lwc1 $f5, zero

	j part1
	
findSqrt:
	# $f12 = x_cur
	mov.s $f12, $f0
	
	div.s $f12, $f12, $f2
	
	# $f11 = x_next
	add.s $f11, $f12, $f3
	
	# $f10 = fabs( x_cur - x_next )
	sub.s $f10, $f12, $f11
	abs.s $f10, $f10
	
	# while loop
	j loop
	
loop:
	# $f10 = fabs( x_cur - x_next )
	sub.s $f10, $f12, $f11
	abs.s $f10, $f10
	
	c.le.s $f10, $f4
	bc1t part2
	
	add.s $f12, $f11, $f5
	
	div.s $f8, $f0, $f12
	add.s $f8, $f8, $f12
	div.s $f8, $f8, $f2
	
	add.s $f11, $f8, $f5
	
	j loop
	
part1:
	# question
	li $v0, 4
	la $a0, ask
	syscall
	
	li $v0, 6
	syscall
	
	j findSqrt
	
part2:
	# print
	li $v0, 4
	la $a0, print
	syscall
	
	li $v0, 2
	syscall
	
	la $v0, 4
	la $a0, newline
	syscall
	
	li $v0, 10
	syscall
	
	
.data
	
	two: .single 2.0
	one: .single 1.0
	longnumber: .single 0.0000001
	zero: .single 0.0
	
	ask: .asciiz "Enter a non-negative number: "
	print: .asciiz "Its square root is: "
	newline: .asciiz "\n"