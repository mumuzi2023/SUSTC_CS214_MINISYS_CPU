.data
 	newline: .asciiz "\n"
.text	
main:
	addi $v0,$zero,5	
	syscall 
	ori $v1,$zero,0		
	beq $v0,0,case0
	beq $v0,1,case1
	beq $v0,2,case2
	beq $v0,3,case3
	beq $v0,4,case4
	beq $v0,5,case5
	beq $v0,6,case6
	beq $v0,7,case7
	j main

case0:
	addi $v0,$zero,5
	syscall
	add $t0, $zero,$v0
        sll  $t0, $t0, 25
        srl  $t0, $t0, 25
        add $a0, $zero, $t0
        addi $v0, $zero, 35
        syscall
  	la $a0, newline   	   
	li $v0,4
	syscall
        add $t2, $zero, 1
        addi $t3, $zero, 7 
        addi $t5, $zero, 25
        Loop0:  	
        add $t1, $zero, $t0
        sllv $t1, $t1, $t5
        srl $t1, $t1, 31
        add $t2, $t2, $t1
        subi $t3, $t3, 1
        addi $t5, $t5, 1 
        bne $t3, $zero, Loop0
        and $t2, $t2, 1
        
        add $a0, $zero, $t2
        addi $v0, $zero, 1
        syscall
  	la $a0, newline   	   
	li $v0,4
	syscall
        
        j main
case1:
	addi $v0,$zero,5
	syscall
	add $t0, $zero,$v0
        add $a0, $zero, $t0
        addi $v0, $zero, 35
        syscall
  	la $a0, newline   	   
	li $v0,4
	syscall
        add $t2, $zero, 0
        addi $t3, $zero, 8 
        addi $t5, $zero, 24
        Loop1:  	
        add $t1, $zero, $t0
        sllv $t1, $t1, $t5
        srl $t1, $t1, 31
        add $t2, $t2, $t1
        subi $t3, $t3, 1
        addi $t5, $t5, 1 
        bne $t3, $zero, Loop1
        and $t2, $t2, 1
        
        add $a0, $zero, $t2
        addi $v0, $zero, 1
        syscall
  	la $a0, newline   	   
	li $v0,4
	syscall
        
        j main
case2:
	addi $v1,$zero,2
	j case7
        tocase2:
	
	or $t2, $t0, $t1
	not $t2, $t2

	add $a0, $zero, $t2
        addi $v0, $zero, 35
        syscall
  	la $a0, newline   	   
	li $v0,4
	syscall	
	j main
case3:
	addi $v1,$zero,3
	j case7
        tocase3:
	
	or $t2, $t0, $t1

	add $a0, $zero, $t2
        addi $v0, $zero, 35
        syscall
  	la $a0, newline   	   
	li $v0,4
	syscall	
	j main
case4:
	addi $v1,$zero,4
	j case7
        tocase4:
	
	xor $t2,$t0,$t1

	add $a0, $zero, $t2
        addi $v0, $zero, 35
        syscall
  	la $a0, newline   	   
	li $v0,4
	syscall	
	j main
case5:
	addi $v1,$zero,5
	j case7
        tocase5:
	
	sltu $t2,$t0,$t1
	
        add $a0, $zero, $t2
        addi $v0, $zero, 1
        syscall
  	la $a0, newline   	   
	li $v0,4
	syscall	
	
	
	j main
case6:
	addi $v1,$zero,6
	j case7
        tocase6:
        
	slt $t2,$t0,$t1
        add $a0, $zero, $t2
        addi $v0, $zero, 1
        syscall
  	la $a0, newline   	   
	li $v0,4
	syscall	
	
	
	j main
case7:
	addi $v0,$zero,5
	syscall
	add $t0, $zero,$v0
	addi $v0,$zero,5
	syscall
	add $t1, $zero,$v0

        add $a0, $zero, $t0
        addi $v0, $zero, 35
        syscall
  	la $a0, newline   	   
	li $v0,4
	syscall
	
        add $a0, $zero, $t1
        addi $v0, $zero, 35
        syscall
  	la $a0, newline   	   
	li $v0,4
	syscall
	
	beq $v1,0,main
	beq $v1,2,tocase2
	beq $v1,3,tocase3
	beq $v1,4,tocase4
	beq $v1,5,tocase5
	beq $v1,6,tocase6
	j main
