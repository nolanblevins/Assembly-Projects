.data
weightPrompt: .asciiz "Enter your weight (in pounds): "
heightPrompt: .asciiz "Enter your height (in feet): "
bmi: .asciiz "Your BMI is: "
underweight: .asciiz "You are underweight."
normal: .asciiz "You are normal weight."
overweight: .asciiz "You are overweight."
newline: .asciiz "\n"
ow:.float 25.0
uw:.float 18.5
hC:.float 12.0   #weight conversion
bM:.float 703.0 # bmi multiplier

.text
main:

#-----------------------------------------------------------
# WEIGHT
li $v0, 4 				# expect string
la $a0, weightPrompt 	#enter weight message
syscall

li $v0, 6 				# expect a float
syscall
mov.s $f1, $f0 			# move float of weight to f1

#-----------------------------------------------------------
# HEIGHT
li $v0, 4 				#expect string
la $a0, heightPrompt 	# enter height message
syscall

li $v0, 6 				# expect a float
syscall
mov.s $f2, $f0			# Move the height to the $f2

# convert height to inches
l.s $f3, hC
mul.s $f2, $f2, $f3

#-----------------------------------------------------------
# BMI CALC
mul.s $f2, $f2, $f2		# square height
div.s $f4, $f1, $f2		# weight divided by height
l.s $f5, bM
mul.s $f6, $f4, $f5		# times 703

#-----------------------------------------------------------
# PRINT BMI
li $v0, 4 # expect string
la $a0, bmi
syscall
    li $v0, 2      			# expect float
    mov.s $f12, $f6 		# move bmi to f12
    syscall
    li $v0, 4			
    la $a0, newline		# newline
    syscall
 #-----------------------------------------------------------
 # FINDING BMI CLASS
l.s $f7, uw			# load underweight value
l.s $f8, ow			# load overweight value
 
c.lt.s $f6, $f7			# bmi is less than 18.5
bc1t underweightBMI 	# go to underweight print
c.lt.s $f7, $f6			# bmi more than 18.5
c.lt.s $f6, $f8			# bmi less than 25
bc1t normalBMI		# go to normal weight print
c.lt.s $f8, $f6			# bmi more than 25
bc1t overweightBMI 	# go to overweight print

#-----------------------------------------------------------
# UNDERWEIGHT PRINT

underweightBMI:
    li $v0, 4
    la $a0, underweight 
    syscall
    
    li $v0, 4
    la $a0, newline
    syscall
    j main
#-----------------------------------------------------------
# NORMAL PRINT

normalBMI:
    li $v0, 4
    la $a0, normal
    syscall
    
    li $v0, 4
    la $a0, newline
    syscall
    j main
#-----------------------------------------------------------
# OVERWEIGHT PRINT

overweightBMI:
    li $v0, 4
    la $a0, overweight
    syscall
    
    li $v0, 4
    la $a0, newline
    syscall
    j main


