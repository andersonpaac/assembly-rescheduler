ORIGIN 4x0000
SEGMENT  CodeSegment:
    LDR  R1, R0, ONE    
    LDR  R2, R0, TWO    
    LDR  R3, R0, EIGHT  
    ADD R4, R3, R2      
LOOP1:
    ADD R3, R3, R3      
    NOT R5, R2          
    ADD R5, R5, R1      
    ADD R4, R4, R5      
    BRzp LOOP1          
    AND R7, R3, R4
    STR R7, R0, RESULT
    LDR R1, R0, RESULT
    NOT R0, R7
    AND R0, R1, R0
    STR R0, R0, RESULT
    LDR R1, R0, GOOD
HALT:                   
    BRnzp HALT          
ONE:    DATA2 4x0001
TWO:    DATA2 4x0002
EIGHT:  DATA2 4x0008
RESULT: DATA2 4x0000
GOOD:   DATA2 4x600D
