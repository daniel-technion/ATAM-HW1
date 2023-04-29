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
    cmpl (%rdi), %r8d
    je save_node_HW1 #current node = value
    jmp continue_HW1
save_node_HW1:
    cmp $0, %rdx
    jne continue_HW1
    movq %rcx, %rdx #save prev addrs
continue_HW1:
    cmpq %rdi, %r9 #check if it's source
    je save_source_parent_HW1
    jmp continue2_HW1
save_source_parent_HW1:
    cmp $0, %rbx
    jne continue2_HW1
    movq %rcx, %rbx
continue2_HW1:
    movq %rdi, %rcx
    movq 4(%rdi), %rdi    #we jump 8 because each int is 4 bytes, rdi = rdi.next
    cmp $0, %rdi      #will jump as long as rdi != 0
    jne loop_HW1



#=======================================================================================


    cmpq $0, %rbx   #pointer to Source's previous
    je sourceIsRoot
    cmpq $0, %rdx   #pointer to value's node previous
    je valIsRootOrMissing
    #neither are 0

normal_swap:
    movq 4(%rdx), %r10 #backup A.next
    movq 4(%rbx), %r11
    movq %r11, 4(%rdx)
    movq %r10, 4(%rbx) #swaps the 'previous' arrows

    #registers have no meaning anymore so why not
    movq 4(%rdx), %rdx
    movq 4(%rbx), %rbx

    movq 4(%rdx), %r10 #backup A.next
    movq 4(%rbx), %r11
    movq %r11, 4(%rdx)
    movq %r10, 4(%rbx) #swaps the 'next' arrows

    jmp end_HW1

sourceIsRoot: #rbx == 0!!!
/*
%rbx   #Source's previous
%rdx   #value's previous
    *set source-next to be val's next
    *set val-next to be source's next
    *set val-previous to be source
*/
    cmpq $0, %rdx
    je valIsRootOrMissingAndBothAreZero

    movq Source(%rip), %rbx #rbx is source
    movq 4(%rdx), %r11 #backup previous-node-value's next
    movq %rbx, 4(%rdx) #previous value's next -> source

    movq %r11, %rdx #now rdx is previous value's next, aka value
    #movq 4(%r11), %rdx #this is completely wrong as it sets rdx to be r11's next (value's next)
    #important? make head point to value

    movq %rdx, head(%rip)

    #movq $node_5, head(%rip)

    movq 4(%rdx), %r10 #backup A.next
    movq 4(%rbx), %r11
    movq %r11, 4(%rdx)
    movq %r10, 4(%rbx) #swaps the 'next' arrows

    jmp end_HW1

valIsRootOrMissingAndBothAreZero:
    #both are 0, either source is value or value n/a
    movq Source(%rip), %rdx #rdx = root
    cmpl %r8d, (%rdx)
    jne end_HW1 #not found
    #val is root AND source is root, no need to swap anything
    jmp end_HW1

valIsRootOrMissing: #rdx = 0, rbx != 0

    movq head(%rip), %rdx #rdx = root
    cmpl %r8d, (%rdx) #check root value vs given value
    jne end_HW1 #not found

    #val is root, source isn't
/*
%rbx   #Source's previous
%rdx   #value's previous
    if val is root: (here it is)
    *set val-next to be source's next
    *set source-next to be val's next
    *set source-previous to be val
*/
    movq 4(%rbx), %r11 #backup previous source's next
    movq %rdx, 4(%rbx) #now source's prev -> val

    movq %r11, %rbx #now rbx is source, aka previous source's next, rdx (val) is source no need to change

    #important! make head point to source
    movq %rbx, head(%rip)

    movq 4(%rbx), %r10 #backup source.next
    movq 4(%rdx), %r11 #backup val.next (second node overall)
    movq %r11, 4(%rbx)
    movq %r10, 4(%rdx) #swaps the 'next' arrows

    jmp end_HW1



end_HW1:
