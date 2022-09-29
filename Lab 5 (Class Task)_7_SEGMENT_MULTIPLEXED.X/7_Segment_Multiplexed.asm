#include "P18F452.inc"
list P=18F452, F=INHX32, MM=OFF

    CONFIG OSC=XT
    CONFIG WDT=OFF
    #define LEDs PORTB
    
    CBLOCK 0X00
    BCD1,BCD2,BCD3,BCD4,BCD_COUNT,TEMP_0,TEMP_1
    ENDC
    
    ORG 0X00
    GOTO MAIN
    ORG 0X200
    
MAIN:
    MOVLB 0X01
    CLRF TRISB
    CLRF TRISD
    CLRF BCD_COUNT, 1
    MOVLW 0X3F
    MOVWF BCD1, 1
    MOVLW 0X06
    MOVWF BCD2, 1
    MOVLW 0X5B
    MOVWF BCD3, 1
    MOVLW 0X4F
    MOVWF BCD4, 1
    CLRF TEMP_0, 1
    CLRF LEDs
    
ENDLESS_LOOP
    CALL DISPLAY
    CALL DELAY
    BRA ENDLESS_LOOP
    
DISPLAY
    MOVF BCD_COUNT, W, 1
    ANDLW 0X03
    MULLW 0X02
    MOVF PRODL, WREG
    ADDWF PCL, F
    BRA DIGIT_1
    BRA DIGIT_2
    BRA DIGIT_3
    BRA DIGIT_4
    RETURN
    
DIGIT_1
    CLRF PORTB
    CLRF PORTD
    MOVF BCD1, W, 1
    MOVWF PORTB
    BSF PORTD, 0
    INCF BCD_COUNT, F, 1
    RETURN
    
DIGIT_2
    CLRF PORTB
    CLRF PORTD
    MOVF BCD2, W, 1
    MOVWF PORTB
    BSF PORTD, 1
    INCF BCD_COUNT, F, 1
    RETURN
    
DIGIT_3
    CLRF PORTB
    CLRF PORTD
    MOVF BCD3, W, 1
    MOVWF PORTB
    BSF PORTD, 2
    INCF BCD_COUNT, F, 1
    RETURN
    
DIGIT_4
    CLRF PORTB
    CLRF PORTD
    MOVF BCD4, W, 1
    MOVWF PORTB
    BSF PORTD, 3
    INCF BCD_COUNT, F, 1
    RETURN
    
DELAY
    MOVLW D'255'
    MOVWF TEMP_1
    
    L1	DECFSZ TEMP_1, F
	BRA L1
    RETURN
END