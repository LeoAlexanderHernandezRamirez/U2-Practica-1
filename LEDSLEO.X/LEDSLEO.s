;))))))))))))))))))))))))))))))))))))))))))))))))))))
; LEO ALEXANDER HERNANDEZ RAMIREZ           7B
;))))))))))))))))))))))))))))))))))))))))))))))))))))
PROCESSOR 16F887
#include <xc.inc>
;////////////////////////////////////////////////////
CONFIG FOSC=INTRC_NOCLKOUT
CONFIG WDTE=OFF
CONFIG PWRTE=ON
CONFIG MCLRE=OFF
CONFIG CP=OFF
CONFIG CPD=OFF
CONFIG BOREN=OFF
CONFIG IESO=OFF
CONFIG FCMEN=ON
CONFIG DEBUG=ON

CONFIG BOR4V=BOR40V
CONFIG WRT=OFF
;/////////////////////////////////////////////////////////
PSECT udata
reg3:
    DS 1
reg2:
    DS 1
reg1:
    DS 1
;////////////////////////////////////////////////////////
PSECT resetVec,class=CODE,delta=2
resetVec:
PAGESEL LED
goto LED
;/////////////////////////////////////////////////////////
PSECT code
retardo:    
MOVLW    50       ; W se carga con el número  (Comienza la llamada)
MOVWF    reg3          ; y se pasa a reg3

externo:   
MOVLW     50        ; W se carga con el número 
MOVWF    reg2          ; y se pasa a reg2
mitad:    
MOVLW    65       ; W se carga con el número 
MOVWF    reg1          ; y se pasa a reg1

interno:    
DECFSZ   reg1,1       ; Le resta una unidad a reg1
GOTO     interno       ; sigue decrementando hasta que reg1 llegue a 0
DECFSZ   reg2,1       ; Le resta una unidad a reg2 cuando reg1 llegue a 0
GOTO        mitad         ; vuelve a cargar reg1 y se repite la rutina interna
DECFSZ   reg3,1       ; Le resto una unidad a reg3 cuando reg2 llegue a 0
GOTO        externo      ; vuelve a cargar reg2 y reg1, se repite la rutina de la mitad
RETURN                      ; Termina la llamada y regresa
    
LED:
    BANKSEL ANSEL
    clrf ANSEL
    BANKSEL PORTA
    clrf PORTA
    BANKSEL TRISA
    clrf TRISA
    BANKSEL PORTA
    
    loop1:
    rrf PORTA,1
    call retardo
    btfss PORTA,0
    goto loop1
    loop2:
    rlf PORTA,1
    call retardo
    btfss PORTA,7
    goto loop2
    goto loop1
    END