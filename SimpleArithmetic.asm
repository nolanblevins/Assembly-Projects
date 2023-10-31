.data

intAprompt: .asciiz "Enter the value for a."
intBprompt: .asciiz "Enter the value for b."
intCprompt: .asciiz "Enter the value for c."
intDprompt: .asciiz "Enter the value for d."

.text
##################################
# print prompt for int a
la $a0, intAprompt #load prompt input
li $v0, 4
syscall #print

# read value a
li $v0, 5
syscall
move $s0, $v0 # move a to s0
###################################
# print prompt for int b
la $a0, intBprompt #load prompt input
li $v0, 4
syscall #print

# read value b
li $v0, 5
syscall
move $s1, $v0 # move b to s1
###################################
# print prompt for int c
la $a0, intCprompt #load prompt input
li $v0, 4
syscall #print

# read value c
li $v0, 5
syscall
move $s2, $v0 # move c to s2
###################################
# print prompt for int d
la $a0, intDprompt #load prompt input
li $v0, 4
syscall #print

# read value d
li $v0, 5
syscall
move $s3, $v0 # move d to s3

#################################
# function: F = (a+b) – (c+d) + (b+3)

add $t1, $s0, $s1  # adding a and b
add $t2, $s2, $s3  # adding c and d
addi $t3, $s1, 3 # adding b and 3
sub $t4, $t1, $t2 # (a+b) - (c+d)
add $t5, $t3, $t4

li $v0, 1
move $a0, $t5 # Move the value from $t5 to $a0
syscall #p rint f

