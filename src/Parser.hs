module Parser where 

import Scanner
import Instructions 
import Text.Printf (printf)

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
-- generateCode :: [Token] -> String
-- generateCode [] = ""
-- generateCode (tok:buff) = case tok of 
--                             LabelTok a -> a ++ generateCode buff
--                             OpcodeTok a -> opcodeToBinary a ++ generateCode buff
--                             NumberTok a -> printf "%b" a ++ generateCode buff
--                             RegisterTok a -> registerToBinary a ++ generateCode buff
--                             DirectiveTok a -> a ++ generateCode buff
--                             MemoryTok a -> a ++ generateCode buff

generateCode :: Token -> String
generateCode tok = case tok of 
                        LabelTok a -> a 
                        OpcodeTok a -> opcodeToBinary a 
                        NumberTok a -> printf "%b" a 
                        RegisterTok a -> registerToBinary a 
                        DirectiveTok a -> a 
                        MemoryTok a -> a 


parseMIPS :: [Token] -> String
parseMIPS [] = ""
parseMIPS buff@(x:xs) = case x of 
                    MemoryTok _ -> generateCode x ++ parseMIPS xs
                    OpcodeTok _ -> parseInstruction buff
                              _ -> error ("[Parse Error] Unexpected Token: " ++ x)

parseInstruction :: [Token] -> String
parseInstruction [] = error "[Parse Error] Expected arguments after opcode: "
parseInstruction (x:xs) = case x of
                                RegisterTok _ -> generateCode x ++ parseMIPS xs
                                NumberTok _ -> parseInstruction x
                                          _ -> error ("[Parse Error] Unexpected Token: " ++ x)

parseRTypeInstruction :: [Token] -> String
parseRTypeInstruction [] = error "[Parse Error] Expected arguments after opcode: "

parseITypeInstruction :: [Token] -> String
parseITypeInstruction [] = error "[Parse Error] Expected arguments after opcode: "

parseJTypeInstruction :: [Token] -> String
parseJTypeInstruction [] = error "[Parse Error] Expected arguments after opcode: "
parseJTypeInstruction (x:xs) = 