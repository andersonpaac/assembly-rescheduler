SEGMENT BOOT:
    BRnzp ldr_str_test
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
DSP:    DATA2 DataSeg
ldr_str_test:
    LDR R0, R0, DSP
    NOP
    NOP
    NOP
    NOP
    NOP
    LDR R1, R0, W
    LDR R3, R0, Y
    LDR R2, R0, X
    LDR R4, R0, Z
    NOP
    STR R1, R0, Z
    STR R2, R0, Y
    STR R3, R0, X
    STR R4, R0, W
    NOP
    LDR R1, R0, W
    LDR R2, R0, X
    LDR R3, R0, Y
    LDR R4, R0, Z
    BRnzp fetch_stall_test
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
fetch_stall_test:
    ADD R5, R1, R2
    ADD R6, R3, R4
    NOP
    NOP
    NOP
    NOP
    STR R5, R0, VICTIM
    ADD R7, R5, R6
    NOP
    NOP
    NOP
    NOP
    STR R7, R0, TOTAL
    LDR R1, R0, TOTAL
inf:
    BRnzp inf
    NOP
    NOP
SEGMENT DataSeg:
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
W:  DATA2 4x0009
X:  DATA2 4x0002
Y:  DATA2 4x0001
Z:  DATA2 4x0003
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
TOTAL:  DATA2 4x0000
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
VICTIM: DATA2 4x0000
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
