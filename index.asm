	ORG     0000H
	AJMP    START
	ORG     0050H
START:  MOV     R3,#32H		;初始化,每秒显示下一个数字
        MOV     R1,#8H		;个位显示8
        MOV     R2,#4H		;十位显示4
        MOV	R4,#32H		;个位为0时,停1秒
SHOW:   LCALL   MAIN		;显示初始值
        DJNZ    R3,SHOW		;保持1s
        MOV     R3,#32H		;复位
        DJNZ    R1,SHOW		;个位减1
        MOV	R4,#32H		;个位为0停1s
LOOP4:  LCALL	MAIN		;个位为零保持显示
	LCALL	DELAY		;同上
        DJNZ	R4,LOOP4	;同上
        MOV     R1,#9H		;个位减至0后并保持后,复位
        MOV	A,R2		;为判断A(十位)是否为0做准备
        JZ	LOOP5		;判断A(十位)是否为零;否,不做操作;是,前往LOOP5做下一步判断
        DJNZ    R2,SHOW		;上一步判断非0,十位减1并显示
        LJMP    SHOW		;我也不知道这步有什么用但写的太晚了不删了(反正能跑)
LOOP5:	MOV	R1,#0H		;让个位为0(程序依靠这个正常,太奇怪了)
	MOV	A,R1		;为判断A(个位)是否为0做准备(直接写0了要判断啥,反正就是要判断)
	JZ	LOOP6		;判断A(个位)是否为零;否,不做操作;是,前往LOOP6做下一步判断
	LJMP	SHOW		;上一步判断非0,继续显示
LOOP6:	MOV	R2,#9H		;复位十位
	MOV     R1,#9H		;复位个位
	LJMP	SHOW		;显示数字
MAIN:   SETB    P2.7		;十位灭
        CLR     P2.6		;个位亮
        MOV     A,R1		;个位送进累加器
        MOV     DPTR,#TABLE1	;数据码表
        MOVC    A,@A+DPTR	;查表
        MOV     P1,A		;显示个位
        ACALL   DELAY		;调用延时
        SETB    P2.6		;个位灭
        CLR     P2.7		;十位亮
        MOV     A,R2		;十位送进累加器
        MOV     DPTR,#TABLE1	;数据码表
        MOVC    A,@A+DPTR	;查表
        MOV     P1,A		;显示十位
        ACALL   DELAY		;调用延时
        RET			;返回SHOW,准备做减法
DELAY:  MOV     R7,#10		;延时10次
LOOP2:  MOV     R6,#250		;再延时250次
LOOP1:  DJNZ    R6,LOOP1	;延时
        DJNZ    R7,LOOP2	;延时
        RET			;返回
TABLE1: DB      0C0H,0F9H,0A4H,0B0H,99H,92H,82H,0F8H,80H,90H	;数据码表
        END