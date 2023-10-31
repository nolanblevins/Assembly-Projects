# int j=3, k = 5;
# printf (“Program starts\n”);
# for (i=0; i<5; i++){
# f = i+j-k;
# printf(“f = %d\n”,f);
# }
# printf (“Program ends\n”);

.data
start: .asciiz "Program starts\n"
printF: .asciiz "f = "
newLine: .asciiz "\n"
end: .asciiz "Program ends\n"

##############################

.text
li $s0, 0 # i = 0
li $s1, 3 # j = 3
li $s2, 5 # k = 5

##############################

li $v0, 4 # 4 for string
la $a0, start
syscall # prints start

##############################

forLoop:
add $t0, $s0, $s1 # i + j
sub $t1, $t0, $s2 # t0 - k
move $s3, $t1 # f = i + j - k

##############################

li $v0, 4 # load w/ string
la $a0, printF # set to string
syscall # f =
li $v0, 1
move $a0, $s3 # move f to print
syscall #'f'

li $v0, 4 # load string
la $a0, newLine
syscall # \n

##############################

addi $s0, $s0, 1 # i++
blt $s0, 5, forLoop # if i < 5 go to loop

##############################

li $v0, 4
la $a0, end
syscall # print end message 



