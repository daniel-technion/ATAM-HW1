.global _start

.section .text
_start:
#your code here
    movq $new_node, %rax      #new node
    movq (%rax), %rbx         #value of new node
    cmp $0, (root)
    je root_null_HW1
    movq root(%rip), %rdi     #pointer
    jmp loop_HW1
root_null_HW1:
    movq %rax, (root)
    jmp end_HW1
loop_HW1:
    cmp (%rdi), %rbx
    je end_HW1
    #cmp (%rdi), %rbx
    jg check_right_HW1

check_left_HW1:
    cmp $0, 8(%rdi)
    je insert_left_HW1
    movq 8(%rdi), %rdi
    jmp loop_HW1

check_right_HW1:
    cmp $0, 16(%rdi)
    je insert_right_HW1
    movq 16(%rdi), %rdi
    jmp loop_HW1

insert_left_HW1:
    movq %rax, 8(%rdi)
    jmp end_HW1
insert_right_HW1:
    movq %rax, 16(%rdi)

end_HW1:

