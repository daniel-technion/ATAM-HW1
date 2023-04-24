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

        jmp end
srcToDest_HW1:
        movl $0, %r11d #counter
        cmp %r8, %r9
        jg reverse #r9 > r8, writing to dest might ruin src, use modified loop
loop:
        movb (%r8, %r11d, 4), %r12d
        movb %r12d, (%r9, %r11d, 4)
        inc %r11d
        cmp %r10d, %r11d
        jne loop
        jmp end
reverse:
        movl %r10d, %r11d #counter
loop_reverse: #need to add _HW1
        movb (%r8, %r11d, 4), %r12d
        movb %r12d, (%r9, %r11d, 4)
        dec %r11d
        cmp $0, %r11d
        jne loop_reverse
        jmp end

end:
