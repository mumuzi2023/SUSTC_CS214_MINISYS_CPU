.data
 	buf:.word 0xFFFFFC60,0xFFFFFC64,0xFFFFFC68,0xFFFFFC6C,0xFFFFFC80,0xFFFFFC70,0xFFFFFC72
.text	
main:
	lui $sp, 0xFFFF
	ori $sp, $sp, 0xFC00
	
	ori $v1,$zero,0	
	
	ori $s0,$zero,0
	ori $s1,$zero,1
	ori $s2,$zero,2
	ori $s3,$zero,3
	ori $s4,$zero,4
	ori $s5,$zero,5
	ori $s6,$zero,6
	ori $s7,$zero,7
	
	add $v0, $zero, $zero 
  	addi $t8,$zero,16	                            	
  	lw $t9, buf($t8)
        pre:
        lw $v0, 0($t9)			
	bne $v0,$s1,pre
        jal sleep
        
	lw $v0, buf($zero)			
	lw $v0, 0($v0)
	
	
	addi $t8,$zero,20	                            	
  	lw $t9, buf($t8)
	sw $s0, 0($t9)
	
	addi $t8,$zero,8	                            	
  	lw $t9, buf($t8)
	sw $s0, 0($t9)
	
	addi $t8,$zero,20	                            	
  	lw $t9, buf($t8)
	sw $v0, 0($t9)
			
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
	add $v0, $zero, $zero 
  	addi $t8,$zero,16	                            	
  	lw $t9, buf($t8)
        pre0:
        lw $v0, 0($t9)			
	bne $v0,$s1,pre0
        jal sleep
	lw $v0, buf($zero)			
	lw $v0, 0($v0)
	#input a
	add $t0, $zero,$v0
	
	addi $t8,$zero,8	                            	
  	lw $t9, buf($t8)
	sw $t0, 0($t9)
	
	add $v0, $zero, $zero 
  	addi $t8,$zero,16	                            	
  	lw $t9, buf($t8)
        pre01:
        lw $v0, 0($t9)			
	bne $v0,$s1,pre01
	add $v0, $zero, $zero 
	
        sll $t0, $t0, 24
        sra $t0, $t0, 24
	slt $t1, $t0,$s0
	beq $t1, $s1, minus
	add $t2, $zero, $zero
	add $t3, $zero, $s1
	add $t0, $t0, $s1
	sum0: 	
	add $t2, $t2, $t3
	add $t3, $t3, $s1
	bne $t3, $t0, sum0
	
	#output sum of a
  	addi $t8,$zero,8	                            	
  	lw $t9, buf($t8)
	sw $t2, 0($t9)
	
	j main
	
	minus:
	add $t8, $zero, $zero
	add $t9, $zero, $zero
	lui $t9, 0x000F
	ori $t9, $t9, 0x4240
	#add $t8,$zero, $s1
	add $t5, $zero, $zero
	Loop0:
	add $t7,$zero,$zero
	blink1:
	
	#outpout t8
  	addi $a2,$zero,8	                            	
  	lw $a3, buf($a2)
	sw $t8, 0($a3)
	
        add $t7,$t7,$s1
        bne $t7,$t9, blink1
        nor $t8, $t8, $s0
        #sll $t8, $t8, 31
        #srl $t8, $t8, 31
        add $t5, $t5, $s1
        bne $t5, $s7, Loop0
	j main
	
case1:
	add $v0, $zero, $zero 
  	addi $t8,$zero,16	                            	
  	lw $t9, buf($t8)
   	addi $t8,$zero,4	                            	
  	lw $a2, buf($t8)
    	addi $t8,$zero,12	                            	
  	lw $a3, buf($t8)
  
         
        pre1:
        lw $a0, 0($a2)
        sw $a0, 0($a3)	
        lw $v0, 0($t9)
        lw $a0, 0($a2)
        sw $a0, 0($a3)			
	bne $v0,$s1,pre1
                jal sleep
	#lw $v0, buf($zero)			
	#lw $v0, 0($v0)
	#input a
	#add $a0, $zero,$v0
	
	addi $t8,$zero,8	                            	
  	lw $t9, buf($t8)
	sw $a0, 0($t9)
	
	add $v0, $zero, $zero 
  	addi $t8,$zero,16	                            	
  	lw $t9, buf($t8)
        pre11:
        lw $v0, 0($t9)			
	bne $v0,$s1,pre11
	add $v0, $zero, $zero 
		
	add $t9, $zero,$zero 
	jal sum1
	sub $v0,$v0,$s1
        #output  
        sll $v0, $v0, 8
        add $v0, $v0, $t9

    	addi $t8,$zero,12	                            	
  	lw $a3, buf($t8)
        sw $t9, 0($a3)	
        sw $t9, 0($a3)
        sw $t9, 0($a3)	
        sw $t9, 0($a3)
        sw $t9, 0($a3)	
        sw $t9, 0($a3)        
  	addi $a2,$zero,8	                            	
  	lw $a3, buf($a2)
	sw $v0, 0($a3)   
    	addi $t8,$zero,12	                            	
  	lw $a3, buf($t8)
        sw $t9, 0($a3)	
        sw $t9, 0($a3)
        sw $t9, 0($a3)	
        sw $t9, 0($a3)
        sw $t9, 0($a3)	
        sw $t9, 0($a3)       
	j main

	sum1:
	add $t9, $t9,$s1 
 	addi $sp, $sp, -8
 	sw $ra, 4($sp)
 	sw $a0, 0($sp)
 	slti $t0, $a0, 1
 	beq $t0, $zero, L1
 	add $t9, $t9,$s1 
 	addi $v0, $zero, 1
 	addi $sp, $sp, 8
 	jr $ra
	L1:
 	addi $a0, $a0, -1
 	jal sum1
 	add $t9, $t9,$s1 
 	lw $a0, 0($sp)
 	lw $ra, 4($sp)
 	addi $sp, $sp, 8
 	add $v0, $a0, $v0
 	jr $ra
case2:

	add $v0, $zero, $zero 
  	addi $t8,$zero,24	                            	
  	lw $t9, buf($t8)
  	add $t7, $zero, $t9
  	sw $s2, 0($t9)
  	
  	addi $t8,$zero,16	                            	
  	lw $t9, buf($t8)
   	addi $t8,$zero,4	                            	
  	lw $a2, buf($t8)
    	addi $t8,$zero,12	                            	
  	lw $a3, buf($t8)
  	
        pre2:
        lw $a0, 0($a2)
        sw $a0, 0($a3)	
        lw $v0, 0($t9)
        lw $a0, 0($a2)
        sw $a0, 0($a3)			
	bne $v0,$s1,pre2
                jal sleep
        sw $a0, 0($t7)
        add $t6, $zero,$a3 
	#lw $v0, buf($zero)			
	#lw $v0, 0($v0)
	#input a
	#add $a0, $zero,$v0
	addi $t8,$zero,8	                            	
  	lw $t9, buf($t8)
	sw $a0, 0($t9)
	
	add $v0, $zero, $zero 
  	addi $t8,$zero,16	                            	
  	lw $t9, buf($t8)
        pre21:
        lw $v0, 0($t9)			
	bne $v0,$s1,pre21
	add $v0, $zero, $zero 
	#addi $t9, $zero, 1
	add $t9, $zero, $zero
	lui $t9, 0x003D
	ori $t9, $t9, 0x0900
	jal sum2   
	j main

	sum2:
 	addi $sp, $sp, -8
 	sw $ra, 4($sp)
 	sw $a0, 0($sp)
	add $t8, $zero, $zero
	add $v1, $zero, $v0
	addi $a2,$zero,8
        sw $a0, 0($t7)
	Loop21:
        addi $t8, $t8, 1                            	
  	lw $a3, buf($a2)
	sw $a0, 0($a3)
  	#addi $a2,$zero,12	                            	
  	#lw $a3, buf($a2)
	sw $a0, 0($t6)	
        bne $t8, $t9, Loop21   
        add $v0, $zero, $v1
 	slti $t0, $a0, 1
 	beq $t0, $zero, L2
 	addi $v0, $zero, 1
 	addi $sp, $sp, 8
 	jr $ra
	L2:
 	addi $a0, $a0, -1
 	jal sum2
 	lw $a0, 0($sp)
 	lw $ra, 4($sp)
 	addi $sp, $sp, 8
 	add $v0, $a0, $v0
 	jr $ra
 	
case3:
	add $v0, $zero, $zero 
  	addi $t8,$zero,16	                            	
  	lw $t9, buf($t8)
   	addi $t8,$zero,4	                            	
  	lw $a2, buf($t8)
    	addi $t8,$zero,12	                            	
  	lw $a3, buf($t8)
        pre3:
        lw $a0, 0($a2)
        sw $a0, 0($a3)	
        lw $v0, 0($t9)
        lw $a0, 0($a2)
        sw $a0, 0($a3)				
	bne $v0,$s1,pre3
                jal sleep
        add $t6, $zero,$a3 
	#lw $v0, buf($zero)			
	#lw $v0, 0($v0)
	#input a
	#add $a0, $zero,$v0
	#addi $t9, $zero, 1
	addi $t8,$zero,8	                            	
  	lw $t9, buf($t8)
	sw $a0, 0($t9)
	
	add $v0, $zero, $zero 
  	addi $t8,$zero,16	                            	
  	lw $t9, buf($t8)
        pre31:
        lw $v0, 0($t9)			
	bne $v0,$s1,pre31
	add $v0, $zero, $zero 
        add $t9, $zero, $zero
	lui $t9, 0x003D
	ori $t9, $t9, 0x0900
	jal sum3   
	j main

	sum3:
 	addi $sp, $sp, -8
 	sw $ra, 4($sp)
 	sw $a0, 0($sp)
 	slti $t0, $a0, 1
 	beq $t0, $zero, L3
  	add $t8, $zero, $zero
	add $v1, $zero, $v0
  	addi $a2,$zero,8
	Loop30:
        addi $t8, $t8, 1	                            	
  	lw $a3, buf($a2)
	sw $a0, 0($a3)
  	#addi $a2,$zero,12	                            	
  	#lw $a3, buf($a2)
	sw $a0, 0($t6)		
        bne $t8, $t9, Loop30   
        add $v0, $zero, $v1
 	addi $v0, $zero, 1
 	addi $sp, $sp, 8
 	jr $ra
	L3:
 	addi $a0, $a0, -1
 	jal sum3
 	lw $a0, 0($sp)
 	lw $ra, 4($sp)
 	add $t8, $zero, $zero
	add $v1, $zero, $v0
  	addi $a2,$zero,8
	Loop31:
        addi $t8, $t8, 1	                            	
  	lw $a3, buf($a2)
	sw $a0, 0($a3)
  	#addi $a2,$zero,12	                            	
  	#lw $a3, buf($a2)
	sw $a0, 0($t6)	
        bne $t8, $t9, Loop31   
        add $v0, $zero, $v1
 	addi $sp, $sp, 8
 	add $v0, $a0, $v0
 	jr $ra
 	
case4:
	jal inputab
	add $v0, $zero, $zero 
  	addi $t8,$zero,16	                            	
  	lw $t9, buf($t8)
        preresult1:
        lw $v0, 0($t9)			
	bne $v0,$s1,preresult1
	add $v0, $zero, $zero 
        jal sleep  
        add $t5, $t0, $t1
        add $t6, $zero, $zero
        #ans is put in t5, t6
        sll $t5, $t5, 24
        sra $t5, $t5, 24
        
	
	add $t3, $zero, $zero
	xor $t3, $t0, $t1
	sll $t3, $t3, 24
        srl $t3, $t3, 31
        
        beq $t3, $s1, nooverflow
	add $t3, $zero, $zero
	xor $t3, $t0, $t5
	sll $t3, $t3, 24
        srl $t3, $t3, 31
                
        beq $t3, $zero, nooverflow
        addi $t6, $t6,1
        nooverflow:
        
        sll $t5, $t5, 24
        srl $t5, $t5, 24
        sll $t6, $t6, 15
        add $t6, $t6, $t5 
  	addi $a2,$zero,8	                            	
  	lw $a3, buf($a2)
	sw $t6, 0($a3)  

	j main
case5:
	jal inputab
	add $v0, $zero, $zero 
  	addi $t8,$zero,16	                            	
  	lw $t9, buf($t8)
        preresult2:
        lw $v0, 0($t9)			
	bne $v0,$s1,preresult2
	add $v0, $zero, $zero 
        jal sleep  	
        sub $t5, $t0, $t1
        add $t6, $zero, $zero
        #ans is put in t5, t6
        sll $t5, $t5, 24
        sra $t5, $t5, 24
        
	
	add $t3, $zero, $zero
	xor $t3, $t0, $t1
	sll $t3, $t3, 24
        srl $t3, $t3, 31
        
        beq $t3, $zero, nooverflow2
	add $t3, $zero, $zero
	xor $t3, $t0, $t5
	sll $t3, $t3, 24
        srl $t3, $t3, 31
                
        beq $t3, $zero, nooverflow2
        addi $t6, $t6,1
        nooverflow2:
        
        sll $t5, $t5, 24
        srl $t5, $t5, 24
        sll $t6, $t6, 15
        add $t6, $t6, $t5 
  	addi $a2,$zero,8	                            	
  	lw $a3, buf($a2)
	sw $t6, 0($a3)    
	
	j main

case6:
	jal inputab
	add $v0, $zero, $zero 
  	addi $t8,$zero,16	                            	
  	lw $t9, buf($t8)
        preresult3:
        lw $v0, 0($t9)			
	bne $v0,$s1,preresult3
	add $v0, $zero, $zero 
        jal sleep  
        add $t5, $zero, $zero
        add $t6, $zero, $zero
        #ans is put in t6
        add $t3, $zero, $zero
        add $t2, $zero,$zero
  	slt $t2, $t0, $s0
  	bne $t2, $s1, cont61
  	add $t3, $t3, $s1
  	nor $t0, $t0, $s0
  	add $t0, $t0, $s1  	
  	cont61:
  	add $t2, $zero, $zero
  	slt $t2, $t1, $s0
  	bne $t2, $s1, cont62
  	add $t3, $t3, $s1
  	nor $t1, $t1, $s0
  	addi $t1, $t1, 1          
        cont62:
  	add $t2, $zero, $zero
        sll $t3, $t3, 31
        srl $t3, $t3, 31
        slt $t2, $t0, $t1
        beq $t2, $s1, cont63
        add $t4, $zero, $t0
        add $t0, $zero, $t1
        add $t1, $zero, $t4
        
        cont63: 
        add $t6, $t6, $t1
        addi $t5, $t5, 1
        bne $t5, $t0, cont63
        
	beq $t3, $zero, output6
  	nor $t6, $t6, $s0
  	addi $t6, $t6, 1  
  		
	#outpout t6
	output6:
	lui $t9, 0x0098
	ori $t9, $t9, 0x9680
	sll $t6, $t6, 16
	srl $t6, $t6, 16
	add $t8, $zero, $zero
	add $a1, $zero, $t6
	Loop61:
        addi $t8, $t8, 1
        
        #output t6 
  	addi $a2,$zero,8	                            	
  	lw $a3, buf($a2)
	sw $a1, 0($a3)        
	
        bne $t8, $t9, Loop61   
              
	j main

case7:
	jal inputab
	add $v0, $zero, $zero 
  	addi $t8,$zero,16	                            	
  	lw $t9, buf($t8)
        preresult4:
        lw $v0, 0($t9)			
	bne $v0,$s1,preresult4
	add $v0, $zero, $zero 
        jal sleep  
        add $t5, $zero, $zero
        add $t6, $zero, $zero
        #ans is put in t5, t6
 
	add $t8, $zero, $zero
	lui $t9, 0x0098
	ori $t9, $t9, 0x9680	
	#addi $t9, $zero, 3
        add $t3, $zero, $zero
        add $t2, $zero,$zero
  	slt $t2, $t0, $s0
  	add $t7, $zero, $t2
  	bne $t2, $s1, cont71
  	add $t3, $t3, $s1
  	nor $t0, $t0, $s0
  	add $t0, $t0, $s1  	
  	cont71:
  	add $t2, $zero, $zero
  	slt $t2, $t1, $s0
  	#add $t7, $zero, $t2
  	bne $t2, $s1, cont72
  	add $t3, $t3, $s1
  	nor $t1, $t1, $s0
  	addi $t1, $t1, 1          
        cont72:
  	add $t2, $zero, $zero
        sll $t3, $t3, 31
        srl $t3, $t3, 31
                
        cont73: 
        slt $t2, $t0, $t6
        beq $t2, $s1, exit71
        add $t6, $t6, $t1
        addi $t5, $t5, 1
        j cont73
        
        exit71:
        sub $t5, $t5, $s1
        add $t0, $t0, $t1
        sub $t6, $t0, $t6 
        
	beq $t3, $zero, output71
  	nor $t5, $t5, $s0
  	addi $t5, $t5, 1  
  		
	#outpout t5
	output71:
	sll $t5, $t5, 24
	srl $t5, $t5, 24
	add $t8, $zero, $zero
	add $a1, $zero, $t5
	Loop70:
        addi $t8, $t8, 1
        
        #output t5 
  	addi $a2,$zero,8	                            	
  	lw $a3, buf($a2)
	sw $a1, 0($a3)     
	
        bne $t8, $t9, Loop70     
	
	beq $t7, $zero, output72
  	nor $t6, $t6, $s0
  	addi $t6, $t6, 1  
	
        output72:
	sll $t6, $t6, 24
	srl $t6, $t6, 24
	add $t8, $zero, $zero
	add $a1, $zero, $t6
	Loop71:
        addi $t8, $t8, 1
        
        #output t6 
  	addi $a2,$zero,8	                            	
  	lw $a3, buf($a2)
	sw $a1, 0($a3)     
	     
	
        bne $t8, $t9, Loop71   
          
  	addi $a2,$zero,8	                            	
  	lw $a3, buf($a2)
	sw $zero, 0($a3)  
	
	j main
inputab:
	#input a
	add $v0, $zero, $zero 
  	addi $t8,$zero,16	                            	
  	lw $t9, buf($t8)
        prea:
        lw $v0, 0($t9)			
	bne $v0,$s1,prea
      add $s0,$zero, $zero
      add $s0,$zero, $zero
      add $s0,$zero, $zero
      add $s0,$zero, $zero
      add $s0,$zero, $zero
      add $s0,$zero, $zero
      add $s0,$zero, $zero
      add $s0,$zero, $zero
      add $s0,$zero, $zero
      add $s0,$zero, $zero 
	lw $v0, buf($zero)			
	lw $v0, 0($v0)
	
	add $t0, $zero,$v0
	addi $t8,$zero,8	                            	
  	lw $t9, buf($t8)
	sw $t0, 0($t9)
	
	#input b
	add $v0, $zero, $zero 
  	addi $t8,$zero,16	                            	
  	lw $t9, buf($t8)
        preb:
        lw $v0, 0($t9)			
	bne $v0,$s1,preb
      add $s0,$zero, $zero
      add $s0,$zero, $zero
      add $s0,$zero, $zero
      add $s0,$zero, $zero
      add $s0,$zero, $zero
      add $s0,$zero, $zero
      add $s0,$zero, $zero
      add $s0,$zero, $zero
      add $s0,$zero, $zero
      add $s0,$zero, $zero 
	lw $v0, buf($zero)			
	lw $v0, 0($v0)
	
	add $t1, $zero,$v0
	sll $t7,$t0,8
	add $t7, $t7, $t1
  	addi $t8,$zero,8	                            	
  	lw $t9, buf($t8)
	sw $t7, 0($t9)
	
	sll $t0, $t0, 24
        sra $t0, $t0, 24
	sll $t1, $t1, 24
        sra $t1, $t1, 24
      
        jr $ra
sleep:
      add $s0,$zero, $zero
      add $s0,$zero, $zero
      add $s0,$zero, $zero
      add $s0,$zero, $zero
      add $s0,$zero, $zero
      add $s0,$zero, $zero
      add $s0,$zero, $zero
      add $s0,$zero, $zero
      add $s0,$zero, $zero
      add $s0,$zero, $zero 
      jr $ra           
