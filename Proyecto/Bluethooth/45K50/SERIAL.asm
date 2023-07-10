
_main:

;SERIAL.c,25 :: 		void main() org 0x2000               //Se define el registro a partir del cual se alamcenara el codigo l�gico
;SERIAL.c,27 :: 		ANSELC = 0;
	CLRF        ANSELC+0 
;SERIAL.c,28 :: 		TRISB = 0x00;                      //Puerto B como salida
	CLRF        TRISB+0 
;SERIAL.c,29 :: 		LATA4_bit = 0;                     //Pin A4 en estado bajo
	BCF         LATA4_bit+0, BitPos(LATA4_bit+0) 
;SERIAL.c,30 :: 		TRISA4_bit = 0;                    //Pin A4 como salida
	BCF         TRISA4_bit+0, BitPos(TRISA4_bit+0) 
;SERIAL.c,31 :: 		TRISA2_bit = 1;                    //Pin A2 como salida
	BSF         TRISA2_bit+0, BitPos(TRISA2_bit+0) 
;SERIAL.c,32 :: 		ANSA2_bit = 0;                     //Pin A2 como digital
	BCF         ANSA2_bit+0, BitPos(ANSA2_bit+0) 
;SERIAL.c,33 :: 		UART1_Init(9600);                  //Se asigna la velocidad del baudrate
	BSF         BAUDCON+0, 3, 0
	MOVLW       4
	MOVWF       SPBRGH+0 
	MOVLW       225
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;SERIAL.c,34 :: 		while(1){
L_main0:
;SERIAL.c,35 :: 		if (UART1_Data_Ready() == 1) {   //Pregunta si ha recibido alg�n dato por el puerto serial
	CALL        _UART1_Data_Ready+0, 0
	MOVF        R0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main2
;SERIAL.c,37 :: 		char Caracter = UART1_Read();  //Guarda el caracter
	CALL        _UART1_Read+0, 0
	MOVF        R0, 0 
	MOVWF       main_Caracter_L2+0 
;SERIAL.c,39 :: 		if (Caracter == '0') {
	MOVF        R0, 0 
	XORLW       48
	BTFSS       STATUS+0, 2 
	GOTO        L_main3
;SERIAL.c,40 :: 		LED_OFF;                     //Apaga el LED
	BCF         LATA4_bit+0, BitPos(LATA4_bit+0) 
;SERIAL.c,41 :: 		UART1_Write_Text("LED APAGADO");
	MOVLW       ?lstr1_SERIAL+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr1_SERIAL+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;SERIAL.c,42 :: 		}
	GOTO        L_main4
L_main3:
;SERIAL.c,43 :: 		else if (Caracter == '1') {
	MOVF        main_Caracter_L2+0, 0 
	XORLW       49
	BTFSS       STATUS+0, 2 
	GOTO        L_main5
;SERIAL.c,44 :: 		LED_ON;                      //Enciende el LED
	BSF         LATA4_bit+0, BitPos(LATA4_bit+0) 
;SERIAL.c,45 :: 		UART1_Write_Text("LED ENCENDIDO");
	MOVLW       ?lstr2_SERIAL+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr2_SERIAL+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;SERIAL.c,46 :: 		}
	GOTO        L_main6
L_main5:
;SERIAL.c,47 :: 		else if (Caracter == '?') {
	MOVF        main_Caracter_L2+0, 0 
	XORLW       63
	BTFSS       STATUS+0, 2 
	GOTO        L_main7
;SERIAL.c,48 :: 		if (BOTON==1) {              //Pregunta el estado del bot�n
	BTFSS       PORTA+0, 2 
	GOTO        L_main8
;SERIAL.c,49 :: 		UART1_Write('0');          //Env�a un 0 si el bot�n no est� presionado
	MOVLW       48
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;SERIAL.c,50 :: 		} else {
	GOTO        L_main9
L_main8:
;SERIAL.c,51 :: 		UART1_Write('1');          //Env�a un 1 si el bot�n est� presionado
	MOVLW       49
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;SERIAL.c,52 :: 		}
L_main9:
;SERIAL.c,53 :: 		}
L_main7:
L_main6:
L_main4:
;SERIAL.c,54 :: 		}
L_main2:
;SERIAL.c,55 :: 		}
	GOTO        L_main0
;SERIAL.c,56 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
