.directive

# test comments

ADD $A0, 4 $ZERO
j $A0, 4 $ZERO
ADD $A0, 4 $t9
SLT $A0, 4 $ZERO #Shouldnt break anything
MULT $A0, 4 $A3
nor $A0, 4 $V0
or $A0, 4 $ra
jr $A0, 4 $A0

add $t0, $t1, $t2

addi $t0, $t1, 10

#j 0x00400000

#neat