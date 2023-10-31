.data 
	aInt:.asciiz "Enter value for a: "
	bInt:.asciiz "Enter value for b: "
	cInt:.asciiz "Enter value for c: "
	overflow:.asciiz "Overflow: "
	noOverflow:.asciiz "No overflow: "
	divError:.asciiz "Division by zero "
	
	
.text
main:
#-----------------------------------------------
# A
    li $v0, 4 # system call for printing string
    la $a0, aInt # load the address of the prompt for a
    syscall

    # Read the input value for a
    li $v0, 5 # system call for reading an integer
    syscall
    move $s0, $v0

#-----------------------------------------------
# B
    li $v0, 4 # system call for printing string
    la $a0, bInt # load the address of the prompt for b
    syscall

    # Read the input value for b
    li $v0, 5 # system call for reading an integer
    syscall
    move $s1, $v0

#-----------------------------------------------
# C
    li $v0, 4 # system call for printing string
    la $a0, cInt # load the address of the prompt for c
    syscall

    # Read the input value for c
    li $v0, 5 # system call for reading an integer
    syscall
    move $s2, $v0
#-----------------------------------------------
# a + b ^ c
# -----------  + (3 * b)
# c - a ^ 2
	
#-----------------------------------------------
numerator:
	move $t0, $s1    # move b to $t0
	move $t2, $s1    # move b to $t2
	move $t1, $s2    # move c to $t1
	j loop
loop:
	blt  $t1, 2, loopDone  # exit loop when c = 0
	mul $t0, $t2, $t0           # result of prev b * curr b in b
	mflo $t3                   # Move the lower 32 bits of the result to $t1
	
	slt $s6, $t3, $zero         # Check if the lower 32 bits of the result are negative
	xor $s5, $t0, $t3           # Check if the sign of the lower 32 bits is different from the sign of the upper 32 bits
	and $s6, $s6, $s5           # Check if both conditions are true
	bne $s6, $zero, overflowPrint    # Branch to the overflow label if overflow has occurred

	subi $t1, $t1, 1           # decrement c
	j loop                # repeat loop
	
loopDone:
	add $t4, $s0, $t0  # add a and b^c, store result in $t4
	j denominator
# numerator stored in $t4
#-----------------------------------------------

denominator:	# c - a * a
	move $t6, $s0 #t6 = a
	move $t7, $s2 #t7 = c
	mul $t6, $t6, $t6 # t6 = a * a
	sub $t7, $t7, $t6 # t7 = c - a * a
	j division
# denominator stored in $t7
	
#-----------------------------------------------
division:
	beqz $t7, divByZero	# branch if div by zero true
	div $t5, $t4, $t7 # else do division
	j additive

#-----------------------------------------------
additive:	# 3 * b
	li $t8, 3
	move $t9, $s1 # stiore b
	mul $t9, $t9, $t8 # b* 3
	add $t9, $t9, $t5 # inequlaity + (3*b)
	j print
#-----------------------------------------------
print:
	li $v0, 4 # system call for printing string
   	la $a0, noOverflow 
   	syscall
	li $v0, 1        # system call for printing an integer
	move $a0, $t9     
	syscall          
	li $v0, 10       # system call for exiting the program
	syscall       
#-----------------------------------------------
overflowPrint:
	 li $v0, 4 # system call for printing string
   	 la $a0, overflow 
   	 syscall
   	 li $v0, 10       # system call for exiting the program
	syscall  
#-----------------------------------------------
divByZero:
	li $v0, 4 # system call for printing string
	la $a0, divError
	syscall
	li $v0, 10       # system call for exiting the program
	syscall  
	

	

	
	
	
	