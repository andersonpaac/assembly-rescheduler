ORIGIN 4x0000
;R4 = a / ANSWER
;R5 = b
;R6 = a
;R1 =-1
;R7 = 0
;R8 = USE
SEGMENT  CodeSegment:
		
		LDR R4 , R4 , SIX ; R0 <= 6 ; This will eventually hold the product -> Running SUM
		LDR R5 , R5 , NINE ; R5 <= 9

SETUP:
		LDR R1 , R0 , NEGONE; R1 = -1  DINC IN FACT
		ADD R5 , R5 , R1 ; R5 = 8
		ADD R6 , R4 , R7 ; R6 = R0 = 6 ; Saving the multiplicand
		
START:		
		ADD R5 , R5 , R7 ; R5 = R5 -> setting nzp  R5 = 8 + 0
		BRnz DONE
		ADD R4 , R6 , R4 ; R6 = R6 + R4
		ADD R5  , R5 , R1 ;  b = b - 1 , R5 = R5 - 1
		BRnzp START
		

DONE:
		BRnzp DONE
		




SIX:    	DATA2 4x0006
NINE:    	DATA2 4x0009
ZERO:		DATA2 4x0000
NEGONE:		DATA2 4xFFFF
