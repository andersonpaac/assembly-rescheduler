ORIGIN 4x0000

;R1 =-1
;R7 = 0
;R8 = USE
SEGMENT  CodeSegment:
		
		ADD R0 , R0 , R0 ; R0 = 0 , cc set
		BRz OKTHEN
		LDR R6 , R6 , NINE ; R6 <= 9
		BRnzp HALT
		



OKTHEN:		
		LDR R5 , R5 , NINE ; R5 <= 9

HALT:
		BRnzp HALT




NINE:    	DATA2 4x0009
