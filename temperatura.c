#include "pic18f4520.h"
#include "config.h"
#include "temperatura.h"
#include "pwm.h"
#include "lcd.h"
#include "itoa.h"
#include "adc.h"

unsigned char superior, inferior, pot;
unsigned char tmp;
char str[6];   

void atualizaLCD(void) {
    tmp = (adc_amostra(0)*10) / 204;
    lcd_cmd(L_L1);
    itoa(tmp,str);
    lcd_dat('T');
    lcd_dat(str[1]);
    lcd_dat(str[2]);
    lcd_dat(str[3]);
    lcd_dat(str[4]);   
    
    itoa(superior,str);
    lcd_dat('H');
    lcd_dat(str[1]);
    lcd_dat(str[2]);
    lcd_dat(str[3]);
    lcd_dat(str[4]);
    
    itoa(inferior,str);
    lcd_dat('L');
    lcd_dat(str[1]);
    lcd_dat(str[2]);
    lcd_dat(str[3]);
    lcd_dat(str[4]);
    
    lcd_cmd(L_L2);
    itoa(pot,str);
    lcd_dat('C');
    lcd_dat(str[1]);
    lcd_dat(str[2]);
    lcd_dat(str[3]);
    lcd_dat(str[4]);
}

void ConfiguraLimiteSuperior(char temp) {
    superior = temp;
    atualizaLCD();
}

void ConfiguraLimiteInferior(char temp) {
    inferior = temp;
    atualizaLCD();
}

void AtualizarSistema(void) {
    pwmInit();
    tmp = (adc_amostra(0)*10) / 204;    
    if(tmp >  superior) {
        pot = 100;
        pwmSet1(99);
    } else if(tmp < inferior) {
        pot = 0;
        pwmSet1(0);
    }else{
        pot = 50;
        pwmSet1(50);
    }    
    atualizaLCD();
}


