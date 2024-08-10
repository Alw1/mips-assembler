.asciiz

#test comments

testLabel: testLabel2:

testLabel2:


testLabel3: ADDI $A0, $ZERO, 102
            j LABEL:
            ADD $T1, $T2, $t9 
LABEL:      MULT $A0, $A3

            or $A0, $ZERO, $ra
            J testLabel:
LABEL:
            JALR LABEL:
            

