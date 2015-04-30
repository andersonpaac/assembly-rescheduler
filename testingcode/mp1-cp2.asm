ORIGIN 0
SEGMENT
CODE:
	ADD R2 , R2, 4 
	LDb R5 , R2 , 9 ; R5 = memory[7+9] = FC
	NOT R4 , R2
	LSHF R0 , R2 , 3
	RSHFL R1 , R2 , 3
	RSHFA R3 , R2 , 3
	ADD R3, R4, 4
	ADD R3, R4, 4
	ADD R3, R4, 4
	ADD R3, R4, 4
	ADD R3, R4, 4
	ADD R3, R4, 4
	ADD R3, R4, 4
	ADD R3, R4, 4
	ADD R3, R4, 4
	ADD R3, R4, 4
	ADD R3, R4, 4
	ADD R3, R4, 4
	ADD R3, R4, 4
	ADD R3, R4, 4
	ADD R3, R4, 4
	ADD R3, R4, 4
	ADD R3, R4, 4
GOODEND:
	ADD R1 , R1 , 8
	BRnzp GOODEND

;byte enable is giving errors on mem_byte_enable
;byte_choose =1 => byte_enable = 10 => even address => even address means write to upper memory

