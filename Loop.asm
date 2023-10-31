# printf(“Loop starts\n”);
# for (i=10; i>0; i-=2) array[i] = i+2;
# printf(“Loop ends\n”); 

.data
start: .asciiz "Loop starts\n"
end: .asciiz "Loop ends\n"
array: .space 40

##############################

.text
li $v0, 4 # string
la $a0, start
syscall # print start

##############################
li $t0, 10 # index
li $t1, 10 # i
forLoop: beqz, $t1, exit  # for (int i=10; i>0; i-=2) {
addi $t2, $t1, 2
sb  $t2, array($t0)        # array[i] = i+2;
addi $t0, $t0, 4		  # }
subi $t1, $t1, 2
j forLoop

##############################
exit:
li $v0, 4 # string
la $a0, end
syscall # print end





