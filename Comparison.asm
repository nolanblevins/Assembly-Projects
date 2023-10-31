.data
promptForA: .asciiz "Enter a: "
promptForB: .asciiz "Enter b: "
promptForC: .asciiz "Enter c: "
minimumMessage: .asciiz "The minimum non-zero number is: "

.text
main:
#-----------------------------------------------------------
# A
li $v0, 4				# load v0 to expect string
la $a0, promptForA		# load prompt into a0 for A
syscall				
li $v0, 5				# load v0 to expect a int
syscall				# read int and place in $t0
move $t0, $v0
#-----------------------------------------------------------
# B
li $v0, 4				# load v0 to expect string
la $a0, promptForB		# load prompt into a0 for B
syscall
li $v0, 5				# load v0 to expect a int
syscall				# read int and place in $t1
move $t1, $v0
#-----------------------------------------------------------
# C
li $v0, 4				# load v0 to expect string
la $a0, promptForC		# load prompt into a0 for C
syscall
li $v0, 5				# load v0 to expect a int
syscall				# read int and place in $t2
move $t2, $v0

#-----------------------------------------------------------
# INITIAL LOGIC
move $t3, $t0 # set min equal to a
beqz $t3, setMinToB #if min is zero set min to b
j checkB # check if b is zero

#-----------------------------------------------------------
# COMPARISONS AND CHECKS
checkB:
	beqz $t1, checkC # if b is zero check c
	j compareAtoB # compare min to b
checkC:
	bnez $t2, compareBtoC # if c is not zero compare b and c
	j printMinimum # if c is zero print min of b
compareBtoC:
	blt $t2, $t3, setMinToC # if c is less than min set min to c
	j printMinimum # if min is lower print
compareAtoB:
	blt $t1, $t3, setMinToB # if b is less than min set min to b
	j checkC # else check if c is min
	

#-----------------------------------------------------------
# PRINT
printMinimum:
	li $v0, 4
	la $a0, minimumMessage
	syscall
	li $v0, 1
	move $a0, $t3
	syscall
	li $v0, 10
	syscall

#-----------------------------------------------------------
# SET MIN
setMinToB:	# sets min to b
	move $t3, $t1
	beqz $t3, setMinToC
	j checkC
setMinToC:	#sets min to c
	move $t3, $t2
	j printMinimum # print min of c
	




