.global _start

.section .text
_start:
        movq $source, %r8
        movq $destination, %r9
        movl (num), %r10d #num is 4 bytes max
        cmp $0, %r10d #edge case of num = 0
        je end_HW1
        cmp $0, %r10d
        jg srcToDest_HW1
        #here for negative num
        movl %r10d, (destination) #that's all ?
        jmp end_HW1

srcToDest_HW1:
        movq $0, %r11 #counter
        cmp %r8, %r9
        jg reverse_HW1 #r9 > r8, writing to dest might ruin src, use modified loop
        #todo need to fix reverse
loop_HW1:
        movb (%r8, %r11, 1), %r12b
        movb %r12b, (%r9, %r11, 1)
        inc %r11d
        cmpl %r10d, %r11d
        jne loop_HW1
        jmp end_HW1

reverse_HW1:
        movl %r10d, %r11d #counter
        dec %r11d #i think it's needed to avoid accessing out of bounds thing - like arr[n-1] instead of arr[n]
loop_reverse_HW1:
        movb (%r8, %r11, 1), %r12b
        movb %r12b, (%r9, %r11, 1)
        dec %r11d
        cmp $0, %r11d
        jge loop_reverse_HW1 #didnt work with r11d != 0, because we need to also move that first bit, this should work
        jmp end_HW1

end_HW1:
