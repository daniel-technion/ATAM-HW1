.global _start

.section .text
_start:
#your code here
    movq head(%rip), %rdi # rdi = * head => in head we have the address of the first node, we need to read its mem address
    #movl $0, %eax         # eax = 0
    cmp $0, %rdi          #if rdi = 0
    je end_HW1                #if rdi = 0
    #movl (%rdi), %eax     # eax = *rdi => the 'data' in the node
    movl (Value), %r8d      #our value

    movq Source(%rip), %r9 #equivlent to movq $Source, %r9 ?
    #todo check if r9 is 0
    movq $0, %rbx   #pointer to Source's previous
    movq $0, %rdx   #pointer to value's node previous

loop_HW1:
    movq 4(%rdi), %rcx #rcx is next node
    cmpq $0, %rcx
    je continue_HW1

    cmpl (%rcx), %r8d
    je save_node_HW1
    jmp continue_HW1
save_node_HW1:
    cmp $0, %rdx
    jne continue_HW1
    movq %rdi, %rdx
continue_HW1:
    cmpq %rcx, %r9
    je save_source_parent_HW1
    jmp continue2_HW1
save_source_parent_HW1:
    cmp $0, %rbx
    jne continue2_HW1
    movq %rdi, %rbx
continue2_HW1:
    movq 4(%rdi), %rdi    #we jump 8 because each int is 4 bytes, rdi = rdi.next
    cmp $0, %rdi      #will jump as long as rdi != 0
    jne loop_HW1
    #jmp end_HW1

swap_HW1:
    #rdi points to the node
    cmp $0, %rdx
    jne swap_previous_val_HW1
    movq head(%rip), %rdi
    cmpl (%rdi), %r8d
    jne end_HW1 #not found
    movq %rdi, %rdx
    jmp swap_src_to_val #

swap_previous_val_HW1:
    movq %r9, 4(%rdx)
    movq 4(%rdx), %rdx
swap_src_to_val:
    movq 4(%rdx), %rax
    movq 4(%r9), %r12
    movq %r12, 4(%rdx) #r12

    cmp $0, %rbx
    je swap_val_to_src
swap2_HW1:
    movq %rdx, 4(%rbx)
swap_val_to_src:
    movq %rax, 4(%r9)
    #movq %rax, 4(%rdi)
jmp end_HW1

end_HW1:
