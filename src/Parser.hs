module Parser where 

-- import Text.Parsec
-- import Text.Parsec.String (Parser)
-- import Instructions
-- import Scanner

-- -- import Text.Parsec (ParseError)
-- import Text.Parsec
-- import Control.Monad (void)
-- -- import Text.Parsec.String.Parsec (try)
-- -- import Text.Parsec.String.Char (oneOf, char, digit, satisfy)
-- -- import Text.Parsec.String.Combinator (many1, choice, chainl1)
-- -- import Control.Applicative ((<|>), many)
-- -- import Control.Monad (void)
-- -- import Data.Char (isLetter, isDigit)
-- -- import FunctionsAndTypesForParsing

-- --   MIPS Grammar

-- --   program ::= [line]
-- --   line ::= [label] instruction | directive | label
-- --   instruction ::= RTypeInstruction | ITypeInstruction | JTypeInstruction
-- --   RTypeInstruction ::= opcode rs rt rd shamt funct
-- --   ITypeInstruction ::= opcode rs rt immediate
-- --   JTypeInstruction ::= opcode address
-- --   directive ::= directiveType [operand]

-- -- type Label = Token::LabelTok

-- -- data Line = RTypeLine Token Instruction
-- --           | ITypeLine Token Instruction
-- --           | JTypeLine Token Instruction
-- --           | LabelLine Token 
-- --           | DirectiveLine Token


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