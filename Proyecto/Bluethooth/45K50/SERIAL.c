/*******************************************************************************
Company:
Microside Technology Inc.

File Name:
Bluethooth.mcppi

Product Revision  :  1
Device            :  X-TRAINER
Driver Version    :  1.0
********************************************************************************/

/*******************************************************************************
Para usar el código con bootloader, configurar como lo indica MICROSIDE:
1) Tools> Options> Output> Output Settings> Marcar "Long HEX format"
2) Project> Edit Project> Insertar 48.000000 en "MCU Clock Frequency [MHz]" box
********************************************************************************/

#pragma orgall 0x1FFF         // Espacio reservado para bootloader
#define LED_ON LATA4_bit = 1  // Se declara una definición donde se asigna el pin de salida y el estado lógico
#define LED_OFF LATA4_bit = 0 // Se declara una definición donde se asigna el pin de salida y el estado lógico
                              //
#define BOTON PORTA.f2                 // Se declara una definición que contine la funcion que determian el estado de una estrada digital

void main() org 0x2000                 // Se define el registro a partir del cual se alamcenara el codigo lógico
{
   ANSELC = 0;
   TRISB = 0x00;                       // Puerto B como salida
   LATA4_bit = 0;                      // Pin A4 en estado bajo
   TRISA4_bit = 0;                     // Pin A4 como salida
   TRISA2_bit = 1;                     // Pin A2 como salida
   ANSA2_bit = 0;                      // Pin A2 como digital
   UART1_Init( 9600 );                 // Se asigna la velocidad del baudrate
   while ( 1 ) {
      if ( UART1_Data_Ready() == 1 ) { // Pregunta si ha recibido algún dato por el puerto serial

         char Caracter = UART1_Read(); // Guarda el caracter

         if ( Caracter == '0' ) {
            LED_OFF;                   // Apaga el LED
            UART1_Write_Text( "LED APAGADO" );
         } else if ( Caracter == '1' ) {
            LED_ON;                    // Enciende el LED
            UART1_Write_Text( "LED ENCENDIDO" );
         } else if ( Caracter == '?' ) {
            if ( BOTON == 1 ) {        // Pregunta el estado del botón
               UART1_Write( '0' );     // Envía un 0 si el botón no está presionado
            } else {
               UART1_Write( '1' );     // Envía un 1 si el botón está presionado
            }
         }
      }
   }
}