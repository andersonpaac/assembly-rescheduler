SEGMENT  CodeSegment:
   LDR R4 , R0 , SAMPLE 
   NOP
   NOP
   NOP
   NOP
   LDB  R5, R0, DAMPLE     
   LDB R6 , R0 , EAMPLE 
   LDR R7 , R0 , EAMPLE 
   NOP
   NOP
   STB R5 , R0 , SAMPLE
   NOP
   NOP
   NOP
   NOP
   NOP
SAMPLE: DATA2 4xA1F0
DAMPLE: DATA2 4x0137
EAMPLE: DATA2 4xE175
POOP:
   BRnzp POOP
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP
ONE:    DATA2 4x0001
TWO:    DATA2 4x0002
NEGONE: DATA2 4xFFFF
TEMP1:  DATA2 4x0001
GOOD:   DATA2 4x600D
BADD:   DATA2 4xBADD
LOOP:
   ADD R3, R1, R2       
   AND R5, R2, R2       
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
   ADD R1, R1, R4       
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP
   BRn DONE
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP
   BRnzp LOOP
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP
HALT:
   LDR  R1, R0, BADD
   BRnzp HALT
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP
DONE:
   LDR  R1, R0, GOOD
   BRnzp DONE
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP
