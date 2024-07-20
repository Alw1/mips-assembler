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

type Parser a = [Token] -> Either String (a, [Token])

eatToken :: Token -> Parser Token
eatToken _ [] = Left "Unexpected end of input"
eatToken expected (t:ts)
    | t == expected = return (t, ts)
    | otherwise     = Left ("Expected " ++ show expected ++ ", but got " ++ show t)

-- currentToken :: Parser a -> Token
-- currentToken stream = head stream

-- currentToken :: Parser a -> Token
-- currentToken stream = take 1 stream

-- program :: [Token] -> String
-- program [] = ""
-- program stream = 


-- line ::= [label] instruction | directive | label
-- line :: Parser String
-- line = do
--     -- case currentToken Parser of
--     --     LabelTok -> InstructionProd
--     --     DirectiveTok -> DirectiveProd
--     --     OpcodeTok -> InstructionProd
        
-- lineParser :: Parser Line
-- lineParser = choice
--     [ RTypeLine <$> (string "RType" *> many1 (oneOf "0123456789"))
--     , ITypeLine <$> (string "IType" *> many1 (oneOf "0123456789"))
--     , JTypeLine <$> (string "JType" *> many1 (oneOf "0123456789"))
--     , LabelLine <$> (string "Label" *> many1 (oneOf "0123456789"))
--     , DirectiveLine <$> (string "Directive" *> many1 (oneOf "0123456789"))
--     ]

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