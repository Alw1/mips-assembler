.directive

# test comments

testLabel:


testLabel2:


testLabel3: ADD $A0, 4 $ZERO
            j $A0, 4 $ZERO
            ADD $A0, 4 $t9
            SLT $S0, 4 $ZERO #Shouldnt break anything
LABEL:      MULT $A0, 4 $A3
            nor $S3, 4 $V0
            or $A0, 4 $ra
            jr $V1, 4 $A0
            add $t0, $t1, $t2
            addi $t0, $t1, 10
            j 000400000

#neat