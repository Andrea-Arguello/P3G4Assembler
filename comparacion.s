@	comparacion.s
@	 by Andrea Arguello 17801 & Javier Anleu 17149

.text
.align 2
.global comparacion

comparacion:
    ldr r5,[r3],#4
    ldr r6,[r3],#4
    ldr r7,[r3],#4
    mov r8,#2

    cmp r5,r6
    bne perder
    cmpeq r6,r7
    bne perder
    beq ganar

perder:
    mov r0,r0
    bl puts
    b exit

ganar:
    mov r0,r1
    muls r2,r2,r8
    ldr r1,[r2]
    bl printf
    b exit

exit:
    mov pc,lr