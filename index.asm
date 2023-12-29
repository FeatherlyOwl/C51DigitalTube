    ORG     0000H
    AJMP    START
    ;ORG     000BH
    ;LJMP    T_INT0
    ORG     0050H
START:  MOV     R3,#50
        MOV     R1,#8
        MOV     R2,#4
        /*MOV     SP,#60H
        MOV     TMOD,#01H
        MOV     TH0,#HIGH(-25000)
        MOV     TL0,#LOW(-25000)
        SETB	PT0
        SETB    ET0
        SETB    EA
        SETB	P3.2
        SETB    TR0
        MOV     R3,#2*/

SHOW:   LCALL   MAIN
        DJNZ    R3,SHOW
        MOV     R3,#200
        DEC     R1
        DJNZ    R1,SHOW
        DEC     R2
        DJNZ    R2,SHOW
        MOV     R1,#9
        MOV     R2,#9
        LJMP    SHOW
MAIN:   SETB    P2.7
        CLR     P2.6
        MOV     A,R1
        MOV     DPTR,#TABLE1
        MOVC    A,@A+DPTR
        MOV     P1,A
        ACALL   DELAY
        SETB    P2.6
        CLR     P2.7
        MOV     A,R2
        MOV     DPTR,#TABLE1
        MOVC    A,@A+DPTR
        MOV     P1,A
        ACALL   DELAY
        
        RET
DELAY:  MOV     R7,#10
LOOP2:  MOV     R6,#250
LOOP1:  DJNZ    R6,LOOP1
        DJNZ    R7,LOOP2
        RET
TABLE1: DB      0C0H,0F9H,0A4H,0B0H,99H,92H,82H,0F8H,80H,90H
        ;ORG     0800H
/*T_INT0: MOV     TH0,#HIGH(-25000)
        MOV     TL0,#LOW(-25000)
        DJNZ    R3,LOOP3
        DEC     R1
        MOV     R2,#20
LOOP3:  LJMP    MAIN*/
        END