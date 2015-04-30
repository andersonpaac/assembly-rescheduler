    ORIGIN 4x0000
    SEGMENT  CodeSegment:
                LDR R0 , R0 , FIVE 
    SETUP:
                LDR R1 , R5 , NEGONE    
                ADD R3 , R0 , R2    
    BEGIN_FACT:    
                ADD R7 , R0 , R1 
                ADD R7 , R7 , R1 
                BRnz    HALT      
                ADD R2 , R0 , R1 
                ADD R0 , R5 , R2 
    MUL_BEGIN:
                ADD R2 , R2 , R1 
                ADD R6 , R3 , R5 
    START:        
                ADD R2 , R2 , R5 
                BRnz BEGIN_FACT  
                ADD R3 , R6 , R3 
                ADD R2  , R2 , R1 
                BRnzp START     
    HALT:
                BRnzp HALT            
    FIVE:                DATA2 4x0005
    NEGONE:                DATA2 4xFFFF
    SIX:                DATA2 4x0006
    THREE:              DATA2 4X0003
    TWO:                DATA2 4X0002
    ONE:                DATA2 4x0001
