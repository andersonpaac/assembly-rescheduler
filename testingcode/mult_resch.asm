ORIGIN 4x0000
SEGMENT  CodeSegment:
        LDR R4 , R4 , SIX 
        LDR R5 , R5 , NINE 
SETUP:
                LDR R1 , R0 , NEGONE
                ADD R6 , R4 , R7 
                ADD R5 , R5 , R1 
START:        
        ADD R5 , R5 , R7 
        BRnz DONE
        ADD R4 , R6 , R4 
        ADD R5  , R5 , R1 
        BRnzp START
DONE:
        BRnzp DONE
SIX:        DATA2 4x0006
NINE:        DATA2 4x0009
ZERO:        DATA2 4x0000
NEGONE:        DATA2 4xFFFF
