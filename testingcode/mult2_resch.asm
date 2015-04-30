ORIGIN 4x0000
SEGMENT  CodeSegment:
        ADD R0 , R0 , R0 
        BRz OKTHEN
        LDR R6 , R6 , NINE 
        BRnzp HALT
OKTHEN:        
        LDR R5 , R5 , NINE 
HALT:
        BRnzp HALT
NINE:        DATA2 4x0009
