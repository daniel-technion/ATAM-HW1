.global _start

.section .text
_start:
#your code here
    movq head(%rip), %rdi # rdi = * head => in head we have the address of the first node, we need to read its mem address
    movl $0, %eax         # eax = 0
    cmp $0, %rdi          #if rdi = 0
    je end                #if rdi = 0
    movl (%rdi), %eax     # eax = *rdi => the 'data' in the node
    movl (val), %r8d      #our value #todo important: check if should be Value or val
.L3:
    movl (%rdi), %ecx     #ecx = value
    cmpl %r8d, %ecx       # if equal
    je swap
    movq 8(%rdi), %rdi    #we jump 8 because each int is 4 bytes, rdi = rdi.next
    testq %rdi, %rdi      #will jump as long as rdi != 0
    jne .L3
    jmp end
swap:
    #rdi points to the node

    movq Source(%rip), %r9 #equivlent to movq $Source, %r9 ?
    #swap between data
    movl (%rdi), %ecx
    movl (%r9), %edx
    movl %ecx, (%r9)
    movl %edx, (%rdi)

    #swap between id
    movl 4(%rdi), %ecx
    movl 4(%r9), %edx
    movl %ecx, 4(%r9)
    movl %edx, 4(%rdi)

    #swap between pointers, not needed?
    #movl 8(%rdi), %ecx
    #movl 8(%r9), %edx
    #movl %ecx, 8(%r9)
    #movl %edx, 8(%rdi)
end:
