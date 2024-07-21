.directive

# test comments

testLabel:


testLabel2:


testLabel3: ADD $A0, 4 $ZERO
            J label:
            ADD $A0, 4 $t9
            #SLT $S0, 4 $ZERO #Shouldnt break anything


            jr label:
            addi $t0, $t1, $t2
            j testLabel3:

#neat