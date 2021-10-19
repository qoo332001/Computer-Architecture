.data
arr1: .word  -2,1,-3,4,-1,2,1,-5,4
len1: .word 9
minint: .word 0x80000000
.text
# s1 = nums base address
# s2 = array1 length
# s3 = min_Integer
# t0=i
# t1=best
# t2=currsum

main:
    la s1,arr1       #load array address to s1
    lw s2,len1       #load array size to s2
    lw s3,minint     #load the smallest integer to s3
    add a0,s1,zero   #set parameter to a0
    add a1,s2,zero   #set parameter to a1
    jal maxSubArray  #and set ra=PC+4 and jump to labet "maxSubArray" 
    li  a7, 1        # set system call number:print a0 register as integer
    ecall
    addi a0,zero,1
    li  a7, 10      # set system call number:end program
    ecall
    
    
maxSubArray:
    addi sp,sp,-20  #change stackpointer and push to stack to save main fucntion local variables
    sw t0,16(sp)     #push t0 register
    sw t1,12(sp)     #push t1 register
    sw t2,8(sp)     #push t2 register
    sw t3,4(sp)    #push t3 register
    sw t4,0(sp)    #push t4 register
    add t0,zero,zero     #i=0
    add t1,s3,zero       #best=min_Integer
    add t2,zero,zero     #currsum=0  
    loop:
        slt t3,t0,a1     #if(i < numsSize) then t3=1
        beq t3,zero,next #if(t3!=1) then break loop
        slli t3,t0,2     #t3=i*4  
        add t4,s1,t3     #t4=nums[i] address
        lw t4,0(t4)      #t4=nums[i]
        slt t3,t2,zero   #if(currsum<0) then t3=1
        bne t3,zero,L1   #if(t3!=0) then jump L1
        add t2,t2,t4     #else currsum = currsum + nums[i];
        j L2             
    L1:
        add t2,t4,zero   #currsum=nums[i]
    L2:
        slt t3,t1,t2     # if(best<currsum) then t3=1
        beq t3,zero,L3   # if(t3==0) then jump L3
        add t1,t2,zero   # best=currsum
    L3:
        addi t0,t0,1     #i++
        j loop
 next:
    add a0,zero,t1       #return best
    lw t0,16(sp)          #restore the saved register t0
    lw t1,12(sp)          #restore the saved register t1
    lw t2,8(sp)          #restore the saved register t2
    lw t3,4(sp)         #restore the saved register t3
    lw t4,0(sp)         #restore the saved register t4
    addi sp,sp,20        #change stackpointer to finish stack pop
    jr ra                #jump to main function

