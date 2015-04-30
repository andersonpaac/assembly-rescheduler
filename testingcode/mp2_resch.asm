ORIGIN 2000
SEGMENT
CodeSegment:    
        ADD R1, R2, R7
        ADD R3, R1, -4
        ADD R1, R1, R3
        ADD R1, R1, R1
        ADD R1, R2, R7
        LDR R3, R1, -4
        AND R5, R2, R2       
        ADD R1, R1, R3
        ADD R1, R2, R0
        ADD R3 , R2 , R0
        ADD R3, R1, R2       
        NOT R6, R1           
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        STR R6, R0, TEMP1    
        LDR R7, R0, TEMP1    
        LDR R1, R1, R4       
    ADD R5 , R7 , R1