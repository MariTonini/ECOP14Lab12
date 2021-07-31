# 1 "main.c"
# 1 "<built-in>" 1
# 1 "<built-in>" 3
# 288 "<built-in>" 3
# 1 "<command line>" 1
# 1 "<built-in>" 2
# 1 "C:/Program Files (x86)/Microchip/MPLABX/v5.35/packs/Microchip/PIC18Fxxxx_DFP/1.2.26/xc8\\pic\\include\\language_support.h" 1 3
# 2 "<built-in>" 2
# 1 "main.c" 2







# 1 "./pic18f4520.h" 1
# 8 "main.c" 2

# 1 "./config.h" 1
# 38 "./config.h"
#pragma config OSC=HS
#pragma config WDT=OFF
#pragma config LVP=OFF
#pragma config DEBUG = OFF
#pragma config WDTPS = 1
# 9 "main.c" 2

# 1 "./lcd.h" 1
# 16 "./lcd.h"
void lcd_init(void);
void lcd_cmd(unsigned char val);
void lcd_dat(unsigned char val);
void lcd_str(const char* str);
# 10 "main.c" 2

# 1 "./pwm.h" 1
# 23 "./pwm.h"
 void pwmSet1(unsigned char porcento);
 void pwmSet2(unsigned char porcento);
 void pwmFrequency(unsigned int freq);
 void pwmInit(void);
# 11 "main.c" 2

# 1 "./temperatura.h" 1




    void ConfiguraLimiteSuperior(char temp);
    void ConfiguraLimiteInferior(char temp);
    void AtualizarSistema(void);
    void atualizaLCD(void);
# 12 "main.c" 2

# 1 "./adc.h" 1
# 27 "./adc.h"
void adc_init(void);

unsigned int adc_amostra(unsigned char canal);
# 13 "main.c" 2


void main(void) {
    (*(volatile __near unsigned char*)0xFC1) = 0x06;
    (*(volatile __near unsigned char*)0xF93) = 0x01;
    (*(volatile __near unsigned char*)0xF94) = 0x00;
    (*(volatile __near unsigned char*)0xF95) = 0x00;
    (*(volatile __near unsigned char*)0xF96) = 0x00;
    (*(volatile __near unsigned char*)0xF93) = 0xF8;

    lcd_init();
    adc_init();

    ConfiguraLimiteSuperior(27);
    ConfiguraLimiteInferior(25);
    for (;;) {
        AtualizarSistema();
    }
}
