.global _start

.section .text
_start:

movl (array1), %eax #move the adress, l for 32 bit adress (%eax is 32 as well)
movl (array2), %ebx
movl (mergedArray), %ecx

xor %rdx, %rdx #counter1
xor %rsi, %rsi #counter2
xor %rdi, %rdi #counter merged

loop_HW1:
movl (%eax, %rdx, 16), r8d #extract the next element in the array from memory
movl (%ebx, %rsi, 16), r9d
cmp %r8d, %r9d
jg arr2entryBigger_HW1

#else arr1 entry is bigger:
# TODO: make sure it is not out-of-range on first iteration
cmp $0, %rdi #if this is first iteration, don't try to check kif equal to last
cmovne %r8d, -16(%ecx, %rdi, 16) #move to merged only if not equal to the last one

copyFirst_HW1:

inc %rdx
inc %rdi
cmp $0, (%ecx, %rdi, 16)
jne loop_HW1

arr2entryBigger_HW1:
# TODO: compare to last entry, make sure it is not out-of-range
movl %r9d, (%ecx, %rdi, 16) 
inc %rsi
inc %rdi
jne loop_HW1

array1End_HW1:

array2End_HW1:

