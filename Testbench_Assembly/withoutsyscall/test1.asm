.data	0x0000
 	buf:.word  0xFFFFFC60, 0xFFFFFC70
.text	0x0000
main:
	lw $v0, buf($zero)		
	lw $v0, 0($v0)
	
	ori $v1,$zero,0	
	ori $s0,$zero,0
	ori $s1,$zero,1
	ori $s2,$zero,2
	ori $s3,$zero,3
	ori $s4,$zero,4
	ori $s5,$zero,5
	ori $s6,$zero,6
	ori $s7,$zero,7
			
	beq $v0,$s0,case0
	beq $v0,$s1,case1
	beq $v0,$s2,case2
	beq $v0,$s3,case3
	beq $v0,$s4,case4
	beq $v0,$s5,case5
	beq $v0,$s6,case6
	beq $v0,$s7,case7
	j main

case0:
	lw $v0, buf($zero)		
	lw $v0, 0($v0)
	add $t0, $zero,$v0
        sll  $t0, $t0, 25
        srl  $t0, $t0, 25
  	addi $t8,$zero,4	                            	
  	lw $t9, buf($t8)
	sw $t0, 0($t9)
        addi $t2, $zero, 1
        addi $t3, $zero, 7 
        addi $t5, $zero, 25
        Loop0:  	
        add $t1, $zero, $t0
        sllv $t1, $t1, $t5
        srl $t1, $t1, 31
        add $t2, $t2, $t1
        sub $t3, $t3, $s1
        addi $t5, $t5, 1 
        bne $t3, $zero, Loop0
        andi $t2, $t2, 1
        
  	addi $t8,$zero,4	                            	
  	lw $t9, buf($t8)
	sw $t2, 0($t9)
        
        j main
case1:
	lw $v0, buf($zero)		
	lw $v0, 0($v0)
	add $t0, $zero,$v0
  	addi $t8,$zero,4	                            	
  	lw $t9, buf($t8)
	sw $t0, 0($t9)
        addi $t2, $zero, 0
        addi $t3, $zero, 8 
        addi $t5, $zero, 24
        Loop1:  	
        add $t1, $zero, $t0
        sllv $t1, $t1, $t5
        srl $t1, $t1, 31
        add $t2, $t2, $t1
        sub $t3, $t3, $s1
        addi $t5, $t5, 1 
        bne $t3, $zero, Loop1
        andi $t2, $t2, 1
        
  	addi $t8,$zero,4	                            	
  	lw $t9, buf($t8)
	sw $t2, 0($t9)
        
        j main
case2:
	addi $v1,$zero,2
	j case7
        tocase2:
	
	or $t2, $t0, $t1
	nor $t2, $t2, $s0

  	addi $t8,$zero,4	                            	
  	lw $t9, buf($t8)
	sw $t2, 0($t9)
	j main
case3:
	addi $v1,$zero,3
	j case7
        tocase3:
	
	or $t2, $t0, $t1

  	addi $t8,$zero,4	                            	
  	lw $t9, buf($t8)
	sw $t2, 0($t9)
	j main
case4:
	addi $v1,$zero,4
	j case7
        tocase4:
	
	xor $t2,$t0,$t1

  	addi $t8,$zero,4	                            	
  	lw $t9, buf($t8)
	sw $t2, 0($t9)
	j main
case5:
	addi $v1,$zero,5
	j case7
        tocase5:
	
	sltu $t2,$t0,$t1
	
  	addi $t8,$zero,4	                            	
  	lw $t9, buf($t8)
	sw $t2, 0($t9)
	
	
	j main
case6:
	addi $v1,$zero,6
	j case7
        tocase6:
	
	slt $t2,$t0,$t1
	
  	addi $t8,$zero,4	                            	
  	lw $t9, buf($t8)
	sw $t2, 0($t9)
	
	
	j main
case7:
	lw $v0, buf($zero)		
	lw $v0, 0($v0)
	add $t0, $zero,$v0
	lw $v0, buf($zero)		
	lw $v0, 0($v0)
	add $t1, $zero,$v0

  	addi $t8,$zero,4	                            	
  	lw $t9, buf($t8)
	sw $t0, 0($t9)
	
  	addi $t8,$zero,4	                            	
  	lw $t9, buf($t8)
	sw $t1, 0($t9)
	
	beq $v1,$s0,main
	beq $v1,$s2,tocase2
	beq $v1,$s3,tocase3
	beq $v1,$s4,tocase4
	beq $v1,$s5,tocase5
	beq $v1,$s6,tocase6
	j main
