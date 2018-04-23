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
inputb:             .asciz   " "
checker:            .asciz  "Todo bien por aca"
exitmessage:        .asciz  "Gracias por jugar. Que tenga un buen dia."
playagain:          .asciz  "Desea jugar otra vez? Presione cualquier numero para jugar o cualquier otro caracter para salir."
error:              .asciz  "Ingreso incorrecto"
moreError:          .asciz  "No puede ingresar mas monedas de las que tiene."
lessError:         .asciz  "Debe apostar al menos 1 moneda."


asciiart:
.asciz "                              .-------.\n                              |Jackpot|\n                  ____________|_______|____________\n                 |  __    __    ___  _____   __    |\n                 | / _\\  / /   /___\\/__   \\ / _\\   |\n                 | \\ \\  / /   //  //  / /\\ \\\\ \\  25|\n                 | _\\ \\/ /___/ \\_//  / /  \\/_\\ \\ []|\n                 | \\__/\\____/\\___/   \\/     \\__/ []|(__)\n                 |===_______===_______===_______===| ||\n                 ||*| _____ |*| _____ |*| _____ |*|| ||\n                 ||*||     ||*||     ||*||     ||*|| ||\n                 ||*||*   *||*||*   *||*||*   *||*|| ||\n                 ||*||_____||*||_____||*||_____||*|| ||\n                 ||*|_______|*|_______|*|_______|*||_//\n                 |===___________________________===|_/\n                 ||*|                           |*||\n                 ||*|                           |*||\n                 ||*|___________________________|*||\n                 |===___________________________===|\n                 |  /___________________________\\  |\n                 |   |                         |   |\n                _|    \\_______________________/    |_\n               (_____________________________________)\n"





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


    /* salida correcta */
  mov r0, #0
  mov r3, #0
  ldmfd sp!, {lr}	/* R13 = SP */
  bx lr
