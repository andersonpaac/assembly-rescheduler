    ORIGIN 0
    SEGMENT CodeSegment:
    Start:
    DATA2 4x1FC7
    LEA R1, DS50501
    LEA R2, DSBADD1
    LDR R7, R2, B74
    LDR R7, R1, S76
    LDR R6, R2, B70
    LDR R7, R0, G7C
    LDR R6, R0, G7C
    LDR R6, R1, S7E
    LDR R6, R2, B78
    LDR R6, R2, B78
    LDR R6, R2, B78
    LDR R5, R2, B62
    LDB R4, R1, S66
    STR R4, R1, S68
    LDR R5, R2, B66
    STB R1, R1, S6A
    STR R1, R1, S64
    STB R2, R0, G60
    ADD R4, R1, 1
    STB R4, R4, S6A
    LEA R0, DSGOOD0
    BRnzp More
    NOP
    SEGMENT DSGOOD0:
    G30: DATA2 4x600D
    G32: DATA2 4x600D
    G34: DATA2 4x600D
    G36: DATA2 4x600D
    G38: DATA2 4x600D
    G3A: DATA2 4x600D
    G3C: DATA2 4x600D
    G3E: DATA2 4x600D
    G40: DATA2 4x00C2
    G42: DATA2 4x0148
    G44: DATA2 4x1122
    G46: DATA2 4x3344
    G48: DATA2 4x5566
    G4A: DATA2 4x7788
    G4C: DATA2 4x99AA
    G4E: DATA2 4xBBCC
    G50: DATA2 4x600D
    G52: DATA2 4x600D
    G54: DATA2 4x600D
    G56: DATA2 4x600D
    G58: DATA2 4x600D
    G5A: DATA2 4x600D
    G5C: DATA2 4x600D
    G5E: DATA2 4x600D
    SEGMENT DSGOOD1:
    G60: DATA2 4x666D
    G62: DATA2 4x677D
    G64: DATA2 4x688D
    G66: DATA2 4x699D
    G68: DATA2 4x6AAD
    G6A: DATA2 4x6BBD
    G6C: DATA2 4x6CCD
    G6E: DATA2 4x6DDD
    G70: DATA2 4x600D
    G72: DATA2 4x600D
    G74: DATA2 4x600D
    G76: DATA2 4x600D
    G78: DATA2 4x600D
    G7A: DATA2 4x600D
    G7C: DATA2 4x600D
    G7E: DATA2 4x600D
    More:
    LEA R1, DS50500
    LEA R2, DSBADD0
    STR R0, R0, G50
    STR R1, R1, S52
    STR R2, R2, B54
    STR R2, R0, G58
    LDR R7, R1, S52
    LDR R5, R2, B5A
    LDR R6, R0, G54
    LDB R5, R1, S46
    ADD R4, R2, 1
    LDB R6, R4, B42
    ADD R6, R5, R6
    LDI R5, R0, G40
    ADD R6, R5, R6
    STI R6, R0, G42
    AND R3, R3, 0
    ADD R3, R3, 13
    STB R6, R0, G30
    ADD R4, R0, 1
    LDB R4, R4, G30
    STR R4, R0, G3A
    BRnzp Loop
    NOP
    SEGMENT DS50500:
    S30:  DATA2 4x5220
    S32:  DATA2 4x5220
    S34:  DATA2 4x5220
    S36:  DATA2 4x5220
    S38:  DATA2 4x5220
    S3A:  DATA2 4x5220
    S3C:  DATA2 4x5220
    S3E:  DATA2 4x5220
    S40:  DATA2 4x5220
    S42:  DATA2 4x5220
    S44:  DATA2 4x5220
    S46:  DATA2 4x5220
    S48:  DATA2 4x5220
    S4A:  DATA2 4x5220
    S4C:  DATA2 4x5220
    S4E:  DATA2 4x5220
    S50:  DATA2 4x5220
    S52:  DATA2 4x5220
    S54:  DATA2 4x5220
    S56:  DATA2 4x5220
    S58:  DATA2 4x5220
    S5A:  DATA2 4x5220
    S5C:  DATA2 4x5220
    S5E:  DATA2 4x5220
    SEGMENT DS50501:
    S60:  DATA2 4x5AA0
    S62:  DATA2 4x5BB0
    S64:  DATA2 4x5CC0
    S66:  DATA2 4x5DD0
    S68:  DATA2 4x5EE0
    S6A:  DATA2 4x5FF0
    S6C:  DATA2 4x5110
    S6E:  DATA2 4x5220
    S70:  DATA2 4x5220
    S72:  DATA2 4x5220
    S74:  DATA2 4x5220
    S76:  DATA2 4x5220
    S78:  DATA2 4x5220
    S7A:  DATA2 4x5220
    S7C:  DATA2 4x5220
    S7E:  DATA2 4x5220
    Loop:
    LDR R5, R1, S34
    LDR R4, R0, G32
    LDR R6, R0, G30
    LDB R6, R0, G34
    LDR R4, R2, B3C
    ADD R3, R3, -1
    BRp Loop
    Halt:   BRnzp Halt
    B10:  DATA2 4xBADD
    B12:  DATA2 4xBADD
    B14:  DATA2 4xB22D
    B16:  DATA2 4xB33D
    B18:  DATA2 4xB44D
    B1A:  DATA2 4xB55D
    B1C:  DATA2 4xB66D
    B1E:  DATA2 4xB77D
    B20:  DATA2 4xB88D
    B22:  DATA2 4xB99D
    B24:  DATA2 4xBAAD
    B26:  DATA2 4xBBBD
    B28:  DATA2 4xBCCD
    B2A:  DATA2 4xBDDD
    B2C:  DATA2 4xBEED
    B2E:  DATA2 4xBFFD
    SEGMENT DSBADD0:
    B30:  DATA2 4xBAAD
    B32:  DATA2 4xBAAD
    B34:  DATA2 4xBAAD
    B36:  DATA2 4xBAAD
    B38:  DATA2 4xBAAD
    B3A:  DATA2 4xBAAD
    B3C:  DATA2 4xBAAD
    B3E:  DATA2 4xBAAD
    B40:  DATA2 4xBAAD
    B42:  DATA2 4xBAAD
    B44:  DATA2 4xBAAD
    B46:  DATA2 4xBAAD
    B48:  DATA2 4xBAAD
    B4A:  DATA2 4xBAAD
    B4C:  DATA2 4xBAAD
    B4E:  DATA2 4xBAAD
    B50:  DATA2 4xBAAD
    B52:  DATA2 4xBAAD
    B54:  DATA2 4xBAAD
    B56:  DATA2 4xBAAD
    B58:  DATA2 4xBAAD
    B5A:  DATA2 4xBAAD
    B5C:  DATA2 4xBAAD
    B5E:  DATA2 4xBAAD
    SEGMENT DSBADD1:
    B60:  DATA2 4xB88D
    B62:  DATA2 4xB99D
    B64:  DATA2 4xBAAD
    B66:  DATA2 4xBBBD
    B68:  DATA2 4xBCCD
    B6A:  DATA2 4xBDDD
    B6C:  DATA2 4xBEED
    B6E:  DATA2 4xBFFD
    B70:  DATA2 4xBADD
    B72:  DATA2 4xBADD
    B74:  DATA2 4xBADD
    B76:  DATA2 4xBADD
    B78:  DATA2 4xBADD
    B7A:  DATA2 4xBADD
    B7C:  DATA2 4xBADD
    B7E:  DATA2 4xBADD
