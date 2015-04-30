ORIGIN 4x0000
;Input goes to R0 in the first line 
;Answer is given in R[3]
;general usage of registers
;------------------------------
;N is the input 
;a is the multiplicand
;b is the multiplier
;R0 = N
;R1 = -1
;R2 = Used for N-1 fact (b)
;R3 = USED FOR MULT and FACT TOTAL ANSWER IS HERE (a)
;R4 =
;R5 = 0
;R6 = MULTIPlicand saved
;R7 = USED FOR DOING SUBTRACTION(INTERNAL)
;---------------------------------------------------------------
;
SEGMENT  CodeSegment:
				LDR R0 , R0 , FIVE ; LOAD FACTORIAL  INPUT HERE
		

;The setup sets up one of the registers - R1 to always be -1 so decrements are possible
;The factorial technique below will compute the factorial by taking N and multiplying by N-1 
;until necessary (N>2)
;The multiplication is executed by putting the multiplicand a in R3 and the multiplier in b R2 and 
;jumping to the multiplication label

SETUP:
				LDR R1 , R5 , NEGONE	;   R1 = -1 (Used for decrimenting)
				ADD R3 , R0 , R2	;       R3 = N (initial running product is N and running products are always stored in R3)


BEGIN_FACT:	
				ADD R7 , R0 , R1 ;   R7 =  R0 - 1      To check if R0 > 2 , we must decriment it by -1 twice and check the branch statement
				ADD R7 , R7 , R1 ;   R7 = R7 - 1 => the second statement       
				BRnz	HALT      ; If the contents in R0 >= 2 stop , we've found our answer
				ADD R2 , R0 , R1 ; To multiply N-1 with N we must store N-1 in one of the registers (R2). 
				ADD R0 , R5 , R2 ; We take that value and also put it in R0 as the next cycle would require this data and multiplication will clobber this register
				;BRnzp MUL_BEGIN ; let's multiply what's in R2 with the contents in R3



;Here b is the multiplier and a is the multiplicand.
;This technique simply finds the product of a and b and puts it back into R3. 
;Multiplication is achived with repetitive adds
MUL_BEGIN:

				ADD R2 , R2 , R1 ; b = b - 1
				ADD R6 , R3 , R5 ; Saving the multiplicand
		
START:		
				ADD R2 , R2 , R5 ; Check if the new b = 0 , and to do so we need to set nzp
				BRnz BEGIN_FACT  ; If it is zero , the multiplication is complete
				ADD R3 , R6 , R3 ; Running sum = R3 , The running sum is updated by adding itself with the multiplier = Sum = Sum + multiplier
				ADD R2  , R2 , R1 ; Decriment the number of times it has to be done R2 = R2 - 1 -> R2 holds the number of times the repititive addition is YET to be done
				BRnzp START     ; Continue multiplying
		

HALT:
				BRnzp HALT			; Same mechanism as in testcode to stay in  a loop infinitely as per spec
				





FIVE:    			DATA2 4x0005
NEGONE:				DATA2 4xFFFF
SIX:				DATA2 4x0006
THREE:              DATA2 4X0003
TWO:                DATA2 4X0002
ONE:                DATA2 4x0001
