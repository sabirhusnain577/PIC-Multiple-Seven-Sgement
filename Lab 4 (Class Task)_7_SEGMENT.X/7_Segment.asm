#include "P18F452.inc"
LIST P=18F452, F=INHX32, MM=OFF

    CONFIG OSC=XT
    CONFIG WDT=OFF
    #define LEDs PORTB
    
    CBLOCK 0x00
    TEMP_0, TEMP_1, T1, T2, T3
    ENDC
    
    ORG 0x00
    GOTO MAIN
    ORG 0x200

MAIN:
    MOVLB 0x01
    MOVLW 0x00
    MOVWF TRISB
    CLRF TEMP_0,1
    CLRF TEMP_1,1
    CLRF LEDs

ENDLESS_LOOP
    MOVF TEMP_0,W,1
    CALL BCD_SevnSeg
    MOVFF WREG, LEDs
    INCF TEMP_0,F,1
    MOVF TEMP_0,W,1
    DAW
    ANDLW 0x0F
    MOVWF TEMP_0,1
    CALL DELAY
    BRA ENDLESS_LOOP

BCD_SevnSeg
    MULLW 0x02
    MOVFF PRODL,WREG
    ADDWF PCL,F
    RETLW 0x3F
    RETLW 0x06
    RETLW 0x5B
    RETLW 0x4F
    RETLW 0x66
    RETLW 0x6D
    RETLW 0x7D
    RETLW 0x07
    RETLW 0x7F
    RETLW 0x6F

DELAY ;500ms Delay, F=10MHz
	        MOVLW D'5'
	        MOVWF T1
    LOP_1   MOVLW D'200'
	        MOVWF T2
    LOP_2   MOVLW D'250'
	        MOVWF T3
    LOP_3   NOP
	        NOP
	        DECF T3,F
	        BNZ LOP_3
	        DECF T2,F
	        BNZ LOP_2
	        DECF T1,F
	        BNZ LOP_1
	RETURN
END