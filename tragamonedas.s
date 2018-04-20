@	tragamonedas.s
@	 by Andrea Arguello 17801 & Javier Anleu 17149


@ datos en .data
.data
.align 2


arreglo:        .word   1,1,1
numero:         .word   111
monedasJugador: .word   20
monedaMaquina:  .word   20
apuesta:        .word   0
input:          .asciz  "%s"
formatoentrada: .asciz  "%d"
palanca:        .asciz "Usted ha apostado %d monedas\nPresione cualquier tecla para jalar la palanca\n"
salida:         .asiz   "SU NUMERO >> %d\n"
win:            .asciz  "FELICIDADES! Ha ganado %d monedas\n"
lose:           .asciz  "Mejor suerte a la proxima\n"
inputMessage:   .asciz  "Ingrese el numero de monedas que desea apostar:\n "
inputb:         .asciz   " "

.text
.align 2
.global main
.type main,%function

main:
    stmfd sp!, {lr}


    ldr r0,=inputMessage
    bl puts

    ldr r0,=formatoentrada
    ldr r1,=apuesta
    bl scanf

    ldr r0,=palanca
    ldr r1,=apuesta
    ldr r1,[r1]
    bl printf

    ldr r0,=input
    ldr r1,=inputb
    bl scanf

    ldr r0,=salida
    ldr r1,=numero
    ldr r1,[r1]
    bl printf


    ldr r3, =arreglo 
    sub r3,r3,#4
    ldr r2,=apuesta
    ldr r0,=lose
    ldr r1,=win
    bl comparacion



    /* salida correcta */
	mov r0, #0
	mov r3, #0
	ldmfd sp!, {lr}	/* R13 = SP */
	bx lr