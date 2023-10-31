.data

firstFloat: .asciiz "Enter the first floating point value "
secFloat: .asciiz "Enter the second floating point value "
resultFloat: .asciiz "Multiplied result "

#	F = A X B
.text

main:

#-----------------------------------------------
# A
	li $v0, 4
	la $a0, firstFloat
	syscall
	
	li $v0, 6
	syscall
	mov.s $f2, $f0
#------------------------------------------------
# B
	li $v0, 4
	la $a0, secFloat
	syscall
	
	li $v0, 6
	syscall
	mov.s $f4, $f0

#-------------------------------------------------
# Multiply
	mul.s $f6, $f2, $f4
	
#-------------------------------------------------
# Print
	
	li $v0, 4
	la $a0, resultFloat
	syscall
	
	li $v0, 2
    	mov.s $f12, $f6
   	syscall
	

