.data
promptNumHw: .asciiz "Enter the number of homeworks: "
promptAvgHwTime: .asciiz "Enter the average time per homework: "
promptNumEx: .asciiz "Enter the number of exercises: "
promptAvgExTime: .asciiz "Enter the average time per exercise: "
totalWork: .asciiz "Total work: "

.text
main:
#-----------------------------------------------------------
# NUM HW
li $v0, 4						# load v0 to expect string
la $a0, promptNumHw			# load prompt into a0 for num HW
syscall				
li $v0, 5						# load v0 to expect a int
syscall						# read int and place in $t0
move $s0, $v0

#-----------------------------------------------------------
# HRS PER HW
li $v0, 4						# load v0 to expect string
la $a0, promptAvgHwTime		# load prompt into a0 for average hw time
syscall				
li $v0, 5						# load v0 to expect a int
syscall						# read int and place in $t0
move $s1, $v0

#-----------------------------------------------------------
# NUM EXERCISES
li $v0, 4						# load v0 to expect string
la $a0, promptNumEx			# load prompt into a0 for num exercises
syscall				
li $v0, 5						# load v0 to expect a int
syscall						# read int and place in $t0
move $s2, $v0

#-----------------------------------------------------------
# HRS PER EXERCISE
li $v0, 4						# load v0 to expect string
la $a0, promptAvgExTime		# load prompt into a0 for avg ex time
syscall				
li $v0, 5						# load v0 to expect a int
syscall						# read int and place in $t0
move $s3, $v0

#-----------------------------------------------------------
# MOVE INPUTS FOR CALC
move $a0, $s0
move $a1, $s1
move $a2, $s2
move $a3, $s3

#-----------------------------------------------------------
# call total func
jal total
# put ret in s6
move $s6, $v0
#-----------------------------------------------------------
# PRINT

# print total
li $v0, 4
la $a0, totalWork
syscall
li $v0, 1
move $a0, $s6
syscall

#exit
li $v0, 10
syscall

#-----------------------------------------------------------
# HW FUNC
hwFunction:
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    # Multiply num hws by avg hours
    mul  $t0, $a0, $a1
    add $v0, $zero, $t0 # place value in return
    # Restore the return address and return
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra
    
#-----------------------------------------------------------
# EXERCISE FUNC
exFunction:
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    # Multiply num exercises by avg hours
    mul $t1, $a0, $a1
    add $v0, $zero, $t1 # place value in return
    # Restore the return address and return
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra
    
#-----------------------------------------------------------
# TOTAL FUNC
total:
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    # Call hw func with num hws and avg hours
    jal hwFunction
    move $t2, $v0
    
    # Call exercise func with num exercises and avg hours
    move $a0, $a2 # move to a0 for func call
    move $a1, $a3 # move to a1 for func call
    jal exFunction
    move $t3, $v0 # move return to t3
    
    # Add the results of hw func and exercise func
    add $v0, $t3, $t2
    
    # Restore the return address and return
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra
    
  




