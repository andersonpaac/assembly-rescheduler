ORIGIN 4x0000

;R1 =-1
;R5 = 0
;R8 = USE
SEGMENT  CodeSegment:
		
		LDR R3 , R3 , SIX ; R0 <= 6 ; This will eventually hold the product -> Running SUM
		LDR R2 , R2 , NINE ; R2 <= 9

SETUP:
		LDR R1 , R0 , NEGONE; R1 = -1  DINC IN FACT
		ADD R2 , R2 , R1 ; R2 = 8
		ADD R6 , R3 , R5 ; R6 = R0 = 6 ; Saving the multiplicand
		
START:		
		ADD R2 , R2 , R5 ; R2 = R2 -> setting nzp  R2 = 8 + 0
		BRnz DONE
		ADD R3 , R6 , R3 ; R6 = R6 + R3
		ADD R2  , R2 , R1 ;  R2 = R2 - 1
		BRnzp START
		

DONE:
		BRnzp DONE
		




SIX:    	DATA2 4x0006
NINE:    	DATA2 4x0009
ZERO:		DATA2 4x0000
NEGONE:		DATA2 4xFFFF
