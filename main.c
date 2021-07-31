/* 
 * File:   main.c
 * Author: Mariana
 *
 * Created on 27 de Julho de 2021, 20:40
 */

#include "pic18f4520.h"
#include "config.h"
#include "lcd.h"
#include "pwm.h"
#include "temperatura.h"
#include "adc.h"

void main(void) {
    ADCON1 = 0x06;
    TRISB = 0x01;
    TRISC = 0x00;
    TRISD = 0x00;
    TRISE = 0x00;
    TRISB = 0xF8;

    lcd_init();    
    adc_init();
    
    ConfiguraLimiteSuperior(27);
    ConfiguraLimiteInferior(25);
    for (;;) {        
        AtualizarSistema();       
    }
}

