    ORIGIN 0
    SEGMENT
    CODE:
    ADD R2 , R2, 4 
    LDb R5 , R2 , 9 
    NOT R4 , R2
    LSHF R0 , R2 , 3
    RSHFL R1 , R2 , 3
    RSHFA R3 , R2 , 3
    ADD R3, R4, 4
    ADD R3, R4, 4
    ADD R3, R4, 4
    ADD R3, R4, 4
    ADD R3, R4, 4
    ADD R3, R4, 4
    ADD R3, R4, 4
    ADD R3, R4, 4
    ADD R3, R4, 4
    ADD R3, R4, 4
    ADD R3, R4, 4
    ADD R3, R4, 4
    ADD R3, R4, 4
    ADD R3, R4, 4
    ADD R3, R4, 4
    ADD R3, R4, 4
    ADD R3, R4, 4
    GOODEND:
    ADD R1 , R1 , 8
    BRnzp GOODEND
