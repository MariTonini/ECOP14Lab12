# 1 "temperatura.c"
# 1 "<built-in>" 1
# 1 "<built-in>" 3
# 288 "<built-in>" 3
# 1 "<command line>" 1
# 1 "<built-in>" 2
# 1 "C:/Program Files (x86)/Microchip/MPLABX/v5.35/packs/Microchip/PIC18Fxxxx_DFP/1.2.26/xc8\\pic\\include\\language_support.h" 1 3
# 2 "<built-in>" 2
# 1 "temperatura.c" 2
# 1 "./pic18f4520.h" 1
# 1 "temperatura.c" 2

# 1 "./config.h" 1
# 38 "./config.h"
#pragma config OSC=HS
#pragma config WDT=OFF
#pragma config LVP=OFF
#pragma config DEBUG = OFF
#pragma config WDTPS = 1
# 2 "temperatura.c" 2

# 1 "./temperatura.h" 1




    void ConfiguraLimiteSuperior(char temp);
    void ConfiguraLimiteInferior(char temp);
    void AtualizarSistema(void);
    void atualizaLCD(void);
# 3 "temperatura.c" 2

# 1 "./pwm.h" 1
# 23 "./pwm.h"
 void pwmSet1(unsigned char porcento);
 void pwmSet2(unsigned char porcento);
 void pwmFrequency(unsigned int freq);
 void pwmInit(void);
# 4 "temperatura.c" 2

# 1 "./lcd.h" 1
# 16 "./lcd.h"
void lcd_init(void);
void lcd_cmd(unsigned char val);
void lcd_dat(unsigned char val);
void lcd_str(const char* str);
# 5 "temperatura.c" 2

# 1 "./itoa.h" 1
# 11 "./itoa.h"
void itoa(unsigned int val, char* str );
# 6 "temperatura.c" 2

# 1 "./adc.h" 1
# 27 "./adc.h"
void adc_init(void);

unsigned int adc_amostra(unsigned char canal);
# 7 "temperatura.c" 2


unsigned char superior, inferior, pot;
unsigned char tmp;
char str[6];

void atualizaLCD(void) {
    tmp = (adc_amostra(0)*10) / 204;
    lcd_cmd(0x80);
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

    lcd_cmd(0xC0);
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
    if(tmp > superior) {
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
