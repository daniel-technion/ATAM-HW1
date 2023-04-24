.global _start

.section .text
_start:

    movq $array1, %rax # move the adress, l for 32 bit adress (%eax is 32 as well)
    movq $array2, %rbx
    movq $mergedArray, %rcx

    xor %rdx, %rdx # counter1
    xor %rsi, %rsi # counter2
    xor %rdi, %rdi # counter merged

    cmp $0, (%rax) # corner cases
    je array1End_HW1
    cmp $0, (%rbx)
    je array2End_HW1

loop_HW1:
    movl (%rax, %rdx, 4), %r8d          # extract the next element in the array from memory
    movl (%rbx, %rsi, 4), %r9d
    cmp %r8d, %r9d
    jg arr2entryBigger_HW1

    # else arr1 entry is bigger:
    cmp $0, %rdi                        # if this is first iteration, don't try to check kif equal to last
    je copyArr1First_HW1
    cmp %r8d, -4(%rcx, %rdi, 4)
    je continue1_HW1
    movl %r8d, (%rcx, %rdi, 4)          # move to merged only if not equal to the last one
    inc %rdi
    jmp continue1_HW1
copyArr1First_HW1:
    movl %r8d, (%rcx, %rdi, 4)
    inc %rdi
continue1_HW1:
    inc %rdx
    cmp $0, (%rax, %rdx, 4)
    jne loop_HW1                        # if we didn't reached the end of arr1, jump back to the loop
    jmp array1End_HW1

arr2entryBigger_HW1:
    cmp $0, %rdi
    je copyArr2First_HW1
    cmp %r9d, -4(%rcx, %rdi, 4)
    je continue2_HW1
    movl %r9d, (%rcx, %rdi, 4)
    inc %rdi
    jmp continue2_HW1
copyArr2First_HW1:
    movl %r9d, (%rcx, %rdi, 4)
    inc %rdi
continue2_HW1:
    inc %rsi
    cmp $0, (%rbx, %rsi, 4)
    jne loop_HW1
    jmp array2End_HW1

array1End_HW1:              # copy the rest of array2
    cmp $0, (%rbx, %rsi, 4)     # check if array2 has ended too
    je end_HW1
    jmp loop_HW1                # array1 has ended, thus we will always copy array2, till they both end

array2End_HW1:             # copy the rest of array1
    cmp $0, (%rax, %rdx, 4)
    je end_HW1                     # don't copy if array1 has ended too
    jmp loop_HW1

end_HW1:
    movl $0, (%rcx, %rdi, 4)
