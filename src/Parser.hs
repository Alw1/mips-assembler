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

peekToken :: [Token] -> Maybe Token
peekToken x =  if null x then 
                 Nothing
               else
                  Just(head x)
            
parseMIPS :: [Token] -> String
parseMIPS [] = ""
parseMIPS (x:xs) = case x of 
                    LabelTok _ -> generateCode x ++ parseMIPS xs
                    DirectiveTok _ -> generateCode x ++ parseMIPS xs
                    OpcodeTok _ -> parseInstruction (x:xs)
                    _           -> error ("[Parse Error] Unexpected Token: " ++ show x)

--   instruction ::= RTypeInstruction | ITypeInstruction | JTypeInstruction
parseInstruction :: [Token] -> String
parseInstruction [] = error "[parseInstruction Error] Expected arguments after opcode: "
parseInstruction stream@(x:xs) 
  | ADD <= op && op <= MTLO  = parseRTypeInstruction stream
  | ADDI <= op && op <= BLEZ = parseITypeInstruction stream
  | JALR <= op && op <= JR   = parseJTypeInstruction stream
  | otherwise                = error ("Shit went wrong here" ++ show x)
  where
    op = case x of 
          OpcodeTok a -> a
          _ -> error "Not an opcode"
                      
--   RTypeInstruction ::= opcode rs rt rd shamt funct
parseRTypeInstruction :: [Token] -> String
parseRTypeInstruction [] = error "[parseRTypeInstruction Error] Expected arguments after opcode: "
parseRTypeInstruction (x:xs)
  | ADD <= op && op <= SUBU  = generateInstruction 3 ++ parseMIPS (drop 3 xs)   -- Arithmetic and Logical Instructions (f $d, $s, $t )
  | MULT <= op && op <= DIVU = generateInstruction 2 ++ parseMIPS (drop 2 xs)   -- Multiplication / Division Instructions
  | SLL <= op && op <= SRA   = generateInstruction 3 ++ parseMIPS (drop 3 xs)    -- Shift Instructions
  | otherwise                = error "Shit went wrong here too"
  where
    op = case x of 
            OpcodeTok a -> a
            _ -> error "Not an opcode"
    generateInstruction args =
      if length xs < args then
        error $ "[parseRTypeInstruction Error] Instruction " ++ show op ++ " Expects " ++ show args ++ " arguments"
      else 
        concatMap generateCode (x : take args xs) ++ "\n"
                 
--   ITypeInstruction ::= opcode rs rt immediate
parseITypeInstruction :: [Token] -> String
parseITypeInstruction [] = error "[parseITypeInstruction Error] Expected arguments after opcode: "
parseITypeInstruction (x:xs)
  | ADDI <= op && op <= XORI  = generateInstruction 3 ++ parseMIPS (drop 3 xs)   -- Immediate Arithmetic and Logical Instructions ($d, $s, n )
  | otherwise                = error "ITYPE NOT FULLY IMPLEMENTED YET"
  where
    op = case x of 
            OpcodeTok a -> a
            _ -> error "Not an opcode"
    generateInstruction args =
      if length xs < args then
        error $ "[parseITypeInstruction Error] Instruction " ++ show op ++ " Expects " ++ show args ++ " arguments"
      else 
        concatMap generateCode (x : take args xs) ++ "\n"
                 
--   JTypeInstruction ::= opcode address
parseJTypeInstruction :: [Token] -> String
parseJTypeInstruction [] = error "[parseJTypeInstruction Error] Expected arguments after opcode: "
parseJTypeInstruction (x:y:xs) = let
                                    opcode = x
                                    address = case y of
                                        (LabelTok a) -> generateCode $ LabelTok a
                                        _ -> error $ "[parseJTypeInstruction Error] Jump instructions require an address." ++ show y
                                  in
                                    generateCode opcode ++ address ++ parseMIPS xs

--   directive ::= directiveType [operand]
parseDirective :: [Token] -> String
parseDirective [] = error "[parseDirective] Expected arguments after directive: "
parseDirective (x:xs) = generateCode x ++ parseMIPS xs


-- Turn each token into binary if there isn't any parser errors 
generateCode :: Token -> String
generateCode tok = case tok of 
                        LabelTok a -> a 
                        OpcodeTok a -> opcodeToBinary a 
                        NumberTok a -> printf "%b" a 
                        RegisterTok a -> registerToBinary a 
                        DirectiveTok a -> a 
                        MemoryTok a -> a 
