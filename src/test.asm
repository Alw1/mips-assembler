.directive

# test comments

testLabel:


testLabel2:


testLabel3: ADD $A0, 4 $ZERO
            j 2034
            ADD $A0, 4 $t9
            #SLT $S0, 4 $ZERO #Shouldnt break anything


            jr 120203
            addi $t0, $t1, $t2
            j 20904

#neat