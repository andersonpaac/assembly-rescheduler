    ORIGIN 4x0000
    SEGMENT  CodeSegment:
    ADD R2 , R3 , EIGHT        
    ADD R7 , R7 , TRY
    AND R1 , R1 , TRY2
    LEA R0 , TRIAL
    HALT:                       
    BRnzp HALT              
    ONE:    DATA2 4x0001
    TWO:    DATA2 4x0002
    EIGHT:  DATA2 4x0008
    RESULT: DATA2 4x0000
    GOOD:   DATA2 4x600D
    TRY:    DATA2 4x000D
    TRY2:     DATA2 4x000C
    TRIAL:    DATA2 4x001A