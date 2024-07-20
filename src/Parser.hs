module Parser where 

import Scanner
import Instructions 
-- import Control.Monad.State

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

--Temporary function until parser is made
generateCode :: [Token] -> String
generateCode [] = ""
generateCode (tok:buff) = case tok of 
                            LabelTok a -> a ++ generateCode buff
                            OpcodeTok a -> opcodeToBinary a ++ generateCode buff
                            NumberTok a -> a ++ generateCode buff
                            RegisterTok a -> show a ++ generateCode buff
                            DirectiveTok a -> a ++ generateCode buff
                           
--  -- Placeholder memory address
-- startAddress = 0x0100

-- -- Assigns memory addreses to labels & directives
-- assignMemoryAddress :: [Token] -> [Token]
-- assignMemoryAddress [] = []
-- assignMemoryAddress tokens@(x:xs) = case tokens of 
--                                     Label x -> 