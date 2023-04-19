.global _start

.section .text
_start:
#your code here
            movq (num), %rax
            movq $0, %rcx #counter (to 64)
            movq $0, %rdx #counts 1's

            
loop_HW1:   movq $1, %rbx
            salq %cl, %rbx
            and %rax, %rbx 
            cmp $0, %rbx 
            jz zero_HW1 #the bit we currently check is 0, skip counter inc
            inc %rdx
zero_HW1:   inc %rcx
            cmp $64, %rcx
            jne loop_HW1

            movb %dl, (Bool) 

