# program 1
.data 

prompt: .asciiz "Hello, may I have your name, please?"
welcome: .asciiz "Welcome "
name: .space 100

.text

la $a0, prompt
li $v0, 4
syscall

la $a0, name
li $a1, 100
li $v0, 8
syscall

la $a0, welcome
li $v0, 4
syscall

la $a0, name
li $v0, 4
syscall

li $v0, 10
syscall
