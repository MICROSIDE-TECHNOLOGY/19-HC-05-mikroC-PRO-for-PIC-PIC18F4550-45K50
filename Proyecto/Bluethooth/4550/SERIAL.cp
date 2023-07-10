#line 1 "C:/Users/Christian/Documents/MikroC-X-TRAINER-main/Practica 20 - MikroC/Proyecto/Bluethooth/4550/SERIAL.c"
#pragma orgall 0x1FFF
#line 24 "C:/Users/Christian/Documents/MikroC-X-TRAINER-main/Practica 20 - MikroC/Proyecto/Bluethooth/4550/SERIAL.c"
void main() org 0x2000
{
 TRISB = 0x00;
 LATA4_bit = 0;
 TRISA4_bit = 0;
 TRISA2_bit = 1;
 UART1_Init(9600);
 while(1){
 if (UART1_Data_Ready() == 1) {

 char Caracter = UART1_Read();

 if (Caracter == '0') {
  LATA4_bit = 0 ;
 UART1_Write_Text("LED APAGADO");
 }
 else if (Caracter == '1') {
  LATA4_bit = 1 ;
 UART1_Write_Text("LED ENCENDIDO");
 }
 else if (Caracter == '?') {
 if ( PORTA.f2 ==1) {
 UART1_Write('0');
 } else {
 UART1_Write('1');
 }
 }
 }
 }
}
