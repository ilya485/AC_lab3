 .syntax unified
.cpu cortex-m4
.thumb

// Global memory locations.
.global vtable_kernel
.global __kernel_reset__

.type vtable_kernel, %object
.type __kernel_reset__, %function

.section .interrupt_vector
vtable_kernel:
    .word __stack_start 
    .word __kernel_reset__+1
    .size vtable_kernel, .-vtable_kernel

.section .rodata
    data: .asciz "kernel started!\n"
    final: .asciz "Value in register #5: "
.section .text
__kernel_reset__:
    ldr r0, =data
    bl dbgput_line

//calculate    
    mov r5, #3  //a
    mov r1, #2  //b
    mov r2, #1  //c
    mov r3, #3
    mov r4, #1

    bl test_var
    pop {pc}

test_var:
    //push { r0, r1, r2, r3, r4, lr }
    sub r5, r1
    mul r5, r3

    mov r3, #2

pow:
    cmp r2, #0
    beq e
    mul r4, r3
    sub r2, #1
    b pow
    
e:
    add r5, r4
    //pop { r0, r1, r2, r3, r4, pc }
    
    ldr r0, =final
    bl dbgput
    mov r0, r5
    bl dbgput_num
    
    end:
    b end

