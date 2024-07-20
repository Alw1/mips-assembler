module Parser where 

import Scanner
import Instructions 

--   MIPS Grammar
--   program ::= [line]
--   line ::= [label] instruction | directive | label
--   instruction ::= RTypeInstruction | ITypeInstruction | JTypeInstruction
--   RTypeInstruction ::= opcode rs rt rd shamt funct
--   ITypeInstruction ::= opcode rs rt immediate
--   JTypeInstruction ::= opcode address
--   directive ::= directiveType [operand]

-- Uses the state monad to update token buffer
-- State, Token Buffer, Current Nonterminal, Current Memory Address
-- type Parser a = State [Token] a Int

type Parser a = [Token] -> (a, [Token]) 

--Temporary function until parser is made
generateCode :: [Token] -> String
generateCode [] = ""
generateCode (tok:buff) = case tok of 
                            LabelTok a -> a ++ generateCode buff
                            OpcodeTok a -> opcodeToBinary a ++ generateCode buff
                            NumberTok a -> a ++ generateCode buff
                            RegisterTok a -> registerToBinary a ++ generateCode buff
                            DirectiveTok a -> a ++ generateCode buff
                            MemoryTok a -> a ++ generateCode buff
                           