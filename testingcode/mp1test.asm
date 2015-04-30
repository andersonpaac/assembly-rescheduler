ORIGIN 4x0000
    ;; Refer to the LC-3b manual for the operation of each
    ;; instruction.  (LDR, STR, ADD, AND, NOT, BR)
SEGMENT  CodeSegment:
    ;; R0 is assumed to contain zero, because of the construction
    ;; of the register file.  (After reset, all registers contain
    ;; zero.)

    ;; Note that the comments in this file should not be taken as
    ;; an example of good commenting style!!  They are merely provided
    ;; in an effort to help you understand the assembly style.

    ADD R2 , R3 , EIGHT    	;Testing Add immediate
    ADD R7 , R7 , TRY
    AND R1 , R1 , TRY2
    LEA R0 , TRIAL

HALT:                   	; Infinite loop to keep the processor
    BRnzp HALT          	; from trying to execute the data below.
                        	; Your own programs should also make use
                        	; of an infinite loop at the end.
ONE:    DATA2 4x0001
TWO:    DATA2 4x0002
EIGHT:  DATA2 4x0008
RESULT: DATA2 4x0000
GOOD:   DATA2 4x600D
TRY:	DATA2 4x000D
TRY2: 	DATA2 4x000C
TRIAL:	DATA2 4x001A


