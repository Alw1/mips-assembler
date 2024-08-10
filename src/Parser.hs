-- module Parser where 

module Parser where

import Scanner
import Instructions
import Text.Printf (printf)

--   MIPS Grammar
--   program ::= line*
--   line ::= [label] instruction | directive | label
--   instruction ::= opcode operands+
--   directive ::= directiveType [operand]

-- Parse a list of tokens into MIPS assembly code
parseMIPS :: [Token] -> String
parseMIPS [] = ""
parseMIPS (x:xs) = case x of 
    LabelTok _        -> generateCode x ++ parseMIPS xs
    DirectiveTok _    -> generateCode x ++ parseMIPS xs
    OpcodeTok _       -> parseInstruction (x:xs) 
    _                 -> error ("[Parse Error] Unexpected Token: " ++ show x)

parseInstruction :: [Token] -> String
parseInstruction [] = error "[parseInstruction Error] Unexpected EOF"
parseInstruction (x:xs) = 
    let numOperands = checkInstruction op xs
    in if length xs < numOperands then 
           error $ "[parseInstruction Error] Expected " ++ show numOperands ++ " arguments, but got " ++ show (length xs)
       else 
           concatMap generateCode (take numOperands xs) ++ concatMap generateCode (take numOperands xs) ++ parseMIPS (drop numOperands xs)
  where
    op = case x of 
          OpcodeTok a -> a
          _           -> error "Expected an opcode token"

checkInstruction :: Opcode -> [Token] -> Int
checkInstruction op tokens = case checkOperands tokens operand of
    Just a  -> a
    Nothing -> error $ "[parseInstruction Error] Instruction " ++ show op ++ " expects operands " ++ show operand ++ "\n\tActual operands: " ++ show tokens
  where
    instruction = filter (\instr -> opcode instr == op) instructions 
    operand = case instruction of
                [] -> error $ "[parseInstruction Error] No such instruction: " ++ show op
                (i:_) -> operands i 

checkOperands :: [Token] -> [Operand] -> Maybe Int
checkOperands [] [] = Just 0
checkOperands (x:xs) (y:ys) = case (x, y) of
    (RegisterTok _, REGISTER) -> fmap (+1) (checkOperands xs ys)
    (NumberTok _, IMMEDIATE)  -> fmap (+1) (checkOperands xs ys)
    (LabelTok _, ADDRESS)     -> fmap (+1) (checkOperands xs ys)
    _ -> Nothing
checkOperands _ _ = Nothing --might be unecessary

generateCode :: Token -> String
generateCode tok = case tok of 
    LabelTok a       -> a 
    OpcodeTok a      -> opcodeToBinary a 
    NumberTok a      -> printf "%b" a 
    RegisterTok a    -> registerToBinary a 
    DirectiveTok a   -> a 

