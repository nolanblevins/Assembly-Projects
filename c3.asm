.data

firstInCount: .asciiz "Enter the first Instruction count value:  "
firstCPI: .asciiz "Enter the first CPI value:  "
firstClkRate:.asciiz "Enter the first Clock Rate:  "
secInCount: .asciiz "Enter the second Instruction count value:  "
secCPI: .asciiz "Enter the second CPI value:  "
secClkRate:.asciiz "Enter the second Clock Rate:  "
firstCPU:.asciiz "A is "
firstCPU2:.asciiz " times as fast as B"
secCPU:.asciiz "B is "
secCPU2:.asciiz " times as fast as A"



#	(CPU TIME = INSTRUCTION_COUNT * CPI) / CLOCK_RATE
.text

main:
#-----------------------------------------------
# First Instruction Count
	li $v0, 4
	la $a0, firstInCount
	syscall
	
	li $v0, 6
	syscall
	mov.s $f2, $f0
#------------------------------------------------
# First CPI Value
	li $v0, 4
	la $a0, firstCPI
	syscall
	
	li $v0, 6
	syscall
	mov.s $f3, $f0
#------------------------------------------------
# First Clock Rate
	li $v0, 4
	la $a0, firstClkRate
	syscall
	
	li $v0, 6
	syscall
	mov.s $f4, $f0
#------------------------------------------------
# Second Instruction Count
	li $v0, 4
	la $a0, secInCount
	syscall
	
	li $v0, 6
	syscall
	mov.s $f5, $f0
#------------------------------------------------
# Second CPI Value
	li $v0, 4
	la $a0, secCPI
	syscall
	
	li $v0, 6
	syscall
	mov.s $f6, $f0
#------------------------------------------------
# Second Clock Rate
	li $v0, 4
	la $a0, secClkRate
	syscall
	
	li $v0, 6
	syscall
	mov.s $f7, $f0
#------------------------------------------------
# f2 = first instruction count
# f3 = first CPI Value
# f4 = first clock rate
# f5 = second instruction cound
# f6 = second cpi value
# f7 = second clock rate
#	(CPU TIME = INSTRUCTION_COUNT * CPI) / CLOCK_RATE
#--------------------
# first CPU time = f8
mul.s $f8, $f2, $f3
div.s $f8, $f8, $f4
#--------------------
# second CPU time = f9
mul.s $f9, $f5, $f6
div.s $f9, $f9, $f7
#--------------------
c.lt.s $f8, $f9
bc1t CPU1
c.lt.s $f9, $f8
bc1t CPU2

#--------------------
CPU2:
	div.s $f10, $f8, $f9
	
	li $v0, 4
	la $a0, secCPU
	syscall
	
	li $v0,2
	mov.s $f12, $f10
	syscall
	
	li $v0, 4
	la $a0, secCPU2
	syscall
	
	li $v0, 10
	li $a0, 0	
	syscall

	
	
	
CPU1:
	div.s $f11, $f9, $f8
	
	li $v0, 4
	la $a0, firstCPU
	syscall
	
	li $v0,2
	mov.s $f12, $f11
	syscall
	
	li $v0, 4
	la $a0, firstCPU2
	syscall
	
	li $v0, 10
	li $a0, 0	
	syscall
	