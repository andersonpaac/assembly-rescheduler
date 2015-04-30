ORIGIN 4x0000
SEGMENT  CodeSegment:
        LDR R3 , R3 , SIX 
        LDR R2 , R2 , NINE 
SETUP:
                LDR R1 , R0 , NEGONE
                ADD R6 , R3 , R5 
                ADD R2 , R2 , R1 
START:        
        ADD R2 , R2 , R5 
        BRnz DONE
        ADD R3 , R6 , R3 
        ADD R2  , R2 , R1 
        BRnzp START
DONE:
        BRnzp DONE
SIX:        DATA2 4x0006
NINE:        DATA2 4x0009
ZERO:        DATA2 4x0000
NEGONE:        DATA2 4xFFFF
