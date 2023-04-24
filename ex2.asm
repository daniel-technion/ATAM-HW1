.global _start

.section .text
_start:
        movq $source, %r8
        movq $destination, %r9
        movl (num), %r10d #num is 4 bytes max
        cmp $0, %r10d
        jg srcToDest_HW1
        #here for negative num
        movq %r10, (destination) #that's all ?
        jmp end_HW1

srcToDest_HW1:
        movl $0, %r11d #counter
        cmp %r8, %r9
        jg reverse #r9 > r8, writing to dest might ruin src, use modified loop
loop_HW1:
        movb (%r8, %r11d), %r12d
        movb %r12d, (%r9, %r11d)
        inc %r11d
        cmp %r10d, %r11d
        jne loop_HW1
        jmp end_HW1

reverse_HW1
        movl %r10d, %r11d #counter
loop_reverse_HW1: #need to add _HW1
        movb (%r8, %r11d), %r12d
        movb %r12d, (%r9, %r11d)
        dec %r11d
        cmp $0, %r11d
        jne loop_reverse_HW1
        jmp end_HW1

end_HW1:
