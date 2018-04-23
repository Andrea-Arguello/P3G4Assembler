/*Intento del tragamonedas 2*/
/*Javier Anleu, 17149 y Andrea Arguello, 17801*/


@ datos en .data
.data
.align 2


arreglo:            .word   1,1,1
numero:             .word   111
monedasJugador:     .word   1
monedaMaquina:      .word   1
apuesta:            .word   0
newRound:           .word   0
input:              .asciz  "%s"
formatoentrada:     .asciz  "%d"
maquina:            .asciz  "La maquina cuenta con %d monedas\n"
jugador:            .asciz  "Usted cuenta con %d monedas\n"
palanca:            .asciz  "Usted ha apostado %d monedas esta ronda\nPresione cualquier tecla para jalar la palanca\n"
salida:             .asciz  "SU NUMERO >> %d\n"
win:                .asciz  "FELICIDADES! Ha ganado %d monedas\n"
lose:               .asciz  "Mejor suerte a la proxima\n"
jugadorMessage:     .asciz  "Ingrese el numero de monedas con las que usted iniciara el juego: "
maquinaMessage:     .asciz  "Ingrese el numero de monedas con las que la maquina inicia el juego:"
apuestaMessage:     .asciz  "Ingrese el numero de monedas que desea apostar:"
nuevaRonda:         .asciz  "Usted cuenta con %d. Desea jugar otra ronda?"
checker:            .asciz  "Todo bien por aca"
exitmessage:        .asciz  "Gracias por jugar. Que tenga un buen dia."
playagain:          .asciz  "Desea jugar otra vez? Presione cualquier numero para jugar o cualquier otro caracter para salir."
error:              .asciz  "Ingreso incorrecto"
moreError:          .asciz  "No puede ingresar mas monedas de las que tiene."
lessError:         .asciz  "Debe apostar al menos 1 moneda."
inputb:             .asciz   " "


asciiart:
.asciz "                              .-------.\n                              |Jackpot|\n                  ____________|_______|____________\n                 |  __    __    ___  _____   __    |\n                 | / _\\  / /   /___\\/__   \\ / _\\   |\n                 | \\ \\  / /   //  //  / /\\ \\\\ \\  25|\n                 | _\\ \\/ /___/ \\_//  / /  \\/_\\ \\ []|\n                 | \\__/\\____/\\___/   \\/     \\__/ []|(__)\n                 |===_______===_______===_______===| ||\n                 ||*| _____ |*| _____ |*| _____ |*|| ||\n                 ||*||     ||*||     ||*||     ||*|| ||\n                 ||*||*   *||*||*   *||*||*   *||*|| ||\n                 ||*||_____||*||_____||*||_____||*|| ||\n                 ||*|_______|*|_______|*|_______|*||_//\n                 |===___________________________===|_/\n                 ||*|                           |*||\n                 ||*|                           |*||\n                 ||*|___________________________|*||\n                 |===___________________________===|\n                 |  /___________________________\\  |\n                 |   |                         |   |\n                _|    \\_______________________/    |_\n               (_____________________________________)\n"

asciiart2:
.asciz "                              .-------.\n                              |Jackpot|\n                  ____________|_______|____________\n                 |  __    __    ___  _____   __    |\n                 | / _\\  / /   /___\\/__   \\ / _\\   |\n                 | \\ \\  / /   //  //  / /\\ \\\\ \\  25|\n                 | _\\ \\/ /___/ \\_//  / /  \\/_\\ \\ []|\n                 | \\__/\\____/\\___/   \\/     \\__/ []|(__)\n                 |===_______===_______===_______===| ||\n                 ||*| _____ |*| _____ |*| _____ |*|| ||\n                 ||*||     ||*||     ||*||     ||*|| ||\n                 ||*||* %d *||*||* %d *||*||* %d *||*|| ||\n                 ||*||_____||*||_____||*||_____||*|| ||\n                 ||*|_______|*|_______|*|_______|*||_//\n                 |===___________________________===|_/\n                 ||*|                           |*||\n                 ||*|                           |*||\n                 ||*|___________________________|*||\n                 |===___________________________===|\n                 |  /___________________________\\  |\n                 |   |                         |   |\n                _|    \\_______________________/    |_\n               (_____________________________________)\n"




.text
.align 2
.global main
.type main,%function

main:
  stmfd sp!, {lr}

  /*Ingreso de monedas iniciales para la maquina*/
  entry1:
    ldr r0,=maquinaMessage
    bl puts

    ldr r0,=formatoentrada
    ldr r1,=monedaMaquina
    bl scanf

    /*Progra defensiva para los caracteres*/
    cmp r0,#0
    beq invalid1

    /*Muestra con cuantas monedas empieza la maquina.*/
    ldr r0,=maquina
    ldr r1,=monedaMaquina
    ldr r1,[r1]
    bl printf

  /*Ingreso de monedas iniciales para el jugador*/
  entry2:
    ldr r0,=jugadorMessage
    bl puts

    /*Progra defensiva para los caracteres*/
    cmp r0,#0
    beq invalid2

    ldr r0,=formatoentrada
    ldr r1,=monedasJugador
    bl scanf

    ldr r0,=jugador
    ldr r1,=monedasJugador
    ldr r1,[r1]
    bl printf





  /*Ciclo principal de juego*/
  maincycle:

    ldr r0,=asciiart
    bl puts

    entry3:
      ldr r0,=apuestaMessage
      bl puts

      ldr r0,=formatoentrada
      ldr r1,=apuesta
      bl scanf

      /*Progra defensiva para los caracteres*/
      cmp r0,#0
      beq invalid3

      ldr r0,=apuesta
      ldr r0,[r0]
      ldr r1,=monedasJugador
      ldr r1,[r1]
      cmp r0,r1
      bgt invalid4
      cmp r0,#0
      ble invalid5

      /*Muestra cuantas monedas aposto e indicaciones para jugar*/
      ldr r0,=palanca
      ldr r1,=apuesta
      ldr r1,[r1]
      bl printf

      /*Scan para jugar*/
      ldr r0,=input
      ldr r1,=inputb
      bl scanf

      ldr r0,=newRound
      ldr r0,[r0]
      ldr r1,=newRound
      ldr r1,[r1]

      randoms:
        /*Asignacion del primer numero*/
        bl randomdos
        mov r2,r0
        and r2,r2,#3
        cmp r2,#0
        beq randoms
        ldr r0,=arreglo
        str r2,[r0]
        /*Asignacion del segundo numero*/
        bl randomdos
        mov r2,r0
        and r2,r2,#3
        cmp r2,#0
        beq randoms
        ldr r0,=arreglo
        add r0, r0, #4
        str r2,[r0]
        /*Asignacion del tercer numero*/
        bl randomdos
        mov r2,r0
        and r2,r2,#3
        cmp r2,#0
        beq randoms
        ldr r0,=arreglo
        add r0, r0, #8
        str r2,[r0]

    ldr r3, =arreglo
    bl comparacion


    /*Secuencia para determinar si se vuelve a jugar.*/

    /*Corrobora si la maquina tiene monedas*/
    ldr r1,=monedaMaquina
    ldr r1, [r1]
    cmp r1,#0
    ble fin

    /*Corrobora si el jugador tiene monedas*/
    ldr r1,=monedasJugador
    ldr r1,[r1]
    cmp r1,#0
    ble fin

    /*Decision para jugar otra vez*/
    ldr r0,=playagain
    bl puts
    ldr r0,=formatoentrada
    ldr r1,=newRound
    bl scanf
    cmp r0,#0
    beq fin
    bne maincycle


  /*Progra defensiva*/
  invalid1:
    ldr r0,=error
    bl puts
    bl getchar
    b entry1

  invalid2:
    ldr r0,=error
    bl puts
    bl getchar
    b entry2

  invalid3:
    ldr r0,=error
    bl puts
    bl getchar
    b entry3

  invalid4:
    ldr r0,=moreError
    bl puts
    bl getchar
    b entry3

  invalid5:
    ldr r0,=lessError
    bl puts
    bl getchar
    b entry3

  fin:
    ldr r0,=exitmessage
    bl puts
    mov r0, #0
    mov r3, #0
    ldmfd sp!, {lr}	/* R13 = SP */
    bx lr


/*Subrutinas*/
comparacion: @compara los 3 numeros del arreglo para ver si son iguales
  ldr r5,[r3],#4
  ldr r6,[r3],#4
  ldr r7,[r3],#4

  ldr r0,=asciiart2
  mov r1,r5
  mov r2, r6
  mov r3, r7
  push {lr}
  bl printf
  pop {lr}

  cmp r5,r7
  push {lr} @para anidar subrutinas
  bne perder
  pop {lr}
  cmpeq r6,r7
  push {lr}
  bne perder
  pop {lr}
  push {lr}
  beq ganar
  pop {lr}

  mov pc,lr

perder:
  push {lr}
  ldr r0,=lose
  @mov r0,r0 @r0 es salida
  bl puts
  pop {lr}

  ldr r8,=apuesta
  ldr r8,[r8]
  ldr r9,=monedaMaquina
  ldr r9,[r9]
  ldr r10,=monedasJugador
  ldr r10,[r10]

  @le suma a la maquina las monedas
  mov r11,#0
  add r11,r9,r8
  ldr r9,=monedaMaquina
  str r11,[r9]

  @coloca el mensaje de monedas en la maquina
  ldr r0,=maquina
  mov r1,r11
  push {lr}
  bl printf
  pop {lr}

  @le resta al jugador las monedas
  mov r11,#0
  sub r11,r10,r8
  ldr r10,=monedasJugador
  str r11,[r10]

  @coloca el mensaje de monedas del jugador
  ldr r0,=jugador
  mov r1,r11
  push {lr}
  bl printf
  pop {lr}

  mov pc, lr

ganar:
  ldr r4,=apuesta
  ldr r4,[r4]
  mov r8,#2
  mul r4,r8,r4 @multiplica la apuesta por dos
  ldr r0,=win
  mov r1,r4
  push {lr}
  bl printf @coloca el mensaje
  pop {lr}

  ldr r3,=monedaMaquina
  ldr r3,[r3]

  @comprueba si la maquina tiene suficientes monedas
  cmp r3,r4
  push {lr}
  blt sinMonedas
  pop {lr}
  push {lr}
  bge conMonedas
  pop {lr}

  mov pc, lr

conMonedas:
  @le resta a la maquina las monedas
  mov r11,#0
  sub r11,r3,r4
  ldr r3,=monedaMaquina
  str r11,[r3]

  @coloca el mensaje de monedas en la maquina
  ldr r0,=maquina
  mov r1,r11
  push {lr}
  bl printf
  pop {lr}


  ldr r10,=monedasJugador
  ldr r10,[r10]

  @le suma al jugador las monedas
  mov r11,#0
  add r11,r10,r4
  ldr r10,=monedasJugador
  str r11,[r10]

  @coloca el mensaje de monedas del jugador
  ldr r0,=jugador
  mov r1,r11
  push {lr}
  bl printf
  pop {lr}
  mov pc,lr

sinMonedas:

  ldr r10,=monedasJugador
  ldr r10,[r10]

  @le suma al jugador las monedas de la maquina
  mov r11,#0
  add r11,r10,r3
  ldr r10,=monedasJugador
  str r11,[r10]

  @coloca el mensaje de monedas del jugador
  ldr r0,=jugador
  mov r1,r11
  push {lr}
  bl printf
  pop {lr}

  @pone la maquina en 0
  mov r11,#0
  ldr r3,=monedaMaquina
  str r11,[r3]

  @coloca el mensaje de monedas en la maquina
  ldr r0,=maquina
  mov r1,r11
  push {lr}
  bl printf
  pop {lr}
  mov pc,lr
