module Parser where 

import Scanner

--   MIPS Grammar

--   program ::= [line]
--   line ::= [label] instruction | directive | label
--   instruction ::= RTypeInstruction | ITypeInstruction | JTypeInstruction
--   RTypeInstruction ::= opcode rs rt rd shamt funct
--   ITypeInstruction ::= opcode rs rt immediate
--   JTypeInstruction ::= opcode address
--   directive ::= directiveType [operand]

-- either returns an error (String) or a tuple with the next production function and the current token stream (a ,[Token])
type Parser a = (a, [Token]) -> Either (a, [Token]) String


parseMIPS :: Parser a -> String
parseMIPS parser = do
                   undefined


-- line ::= [label] instruction | directive | label
-- line :: Parser String
-- line = do
--     -- case currentToken Parser of
--     --     LabelTok -> InstructionProd
--     --     DirectiveTok -> DirectiveProd
--     --     OpcodeTok -> InstructionProd
        


-- lineParser :: Parser Line

-- -- Example of using the line parser
-- parseLines :: String -> Either ParseError [Line]
-- parseLines input = parse (many lineParser) "" input



-- --Start of the parser 

 
--  -- Placeholder memory address
-- startAddress = 0x0100

-- -- Assigns memory addreses to labels & directives
-- assignMemoryAddress :: [Token] -> [Token]
-- assignMemoryAddress [] = []
-- assignMemoryAddress tokens@(x:xs) = case tokens of 
--                                     Label x -> 