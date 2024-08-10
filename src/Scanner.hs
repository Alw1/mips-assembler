module Scanner where

import Data.Char (isDigit, isAlpha, isAlphaNum, isSpace)
import Instructions 
import Text.Printf (printf)

data Token =  LabelTok String
            | DirectiveTok String --Maybe(String) -- directive argument
            | OpcodeTok Opcode
            | RegisterTok Register
            | NumberTok Int
            deriving(Show, Eq)

-- Creates a list of all tokens in a given line
tokenize :: String -> [Token]
tokenize [] = []
tokenize line@(x:xs)
    | isDigit x = tokenizeNumber line
    | isAlpha x = tokenizeLabel line
    | isSpace x || x == ',' = tokenize xs -- ignores whitespace & commas
    | x == '#' || x == ';' = tokenize []              -- ignore line if its a comment
    | x == '$' = tokenizeRegister xs
    | x == '.' = tokenizeDirective xs
    | otherwise = error $ "[Scanner Error] Unexpected input in line" ++ line

tokenizeRegister :: String -> [Token]
tokenizeRegister [] = []
tokenizeRegister line = let (register, line_tail) = span isAlphaNum line
                        in RegisterTok (toRegister register) : tokenize line_tail

tokenizeNumber :: String -> [Token]
tokenizeNumber [] = []
tokenizeNumber line = let (num, line_tail) = span isDigit line
                      in NumberTok (read num) : tokenize line_tail

tokenizeDirective :: String -> [Token]
tokenizeDirective [] = []
tokenizeDirective str = let (dir, line_tail) = span isAlpha str
                        in 
                           if isDirective dir then DirectiveTok dir : tokenize line_tail
                           else error $ "[Scanner Error] Invalid Directive: " ++ dir 
      
tokenizeLabel :: String -> [Token]
tokenizeLabel [] = []
tokenizeLabel str =  let (label, line_tail) = span isAlphaNum str
                     in 
                        if (not.null) line_tail && (not.isOpcode) label then 
                           LabelTok label : tokenize (tail line_tail)
                        else 
                           tokenizeOpcode str 

tokenizeOpcode :: String -> [Token]
tokenizeOpcode [] = []
tokenizeOpcode str = let (op, line_tail) = span isAlpha str
                     in 
                        case toOpcode op of
                           Just a ->  OpcodeTok a : tokenize line_tail
                           Nothing -> error $ "[Scanner Error] " ++ op ++ " is not an opcode"
                       

-- Transform labels and directives into memory addresses             
assignMemory :: Int -> [[Token]] -> [[Token]]
assignMemory _ [] = []
assignMemory address (x:xs) = assignMemory' address x : assignMemory (address + size) xs
  where
    size = 0x08 -- Size of memory address
    assignMemory' :: Int -> [Token] -> [Token]
    assignMemory' _ [] = []
    assignMemory' addr (t:ts) = case t of
        LabelTok _      -> LabelTok (printf "%08b" addr) : assignMemory' (addr + size) ts
        DirectiveTok _  -> DirectiveTok (printf "%08b" addr) : assignMemory' (addr + size) ts
        _               -> t : assignMemory' addr ts

-- Add error checking in directive and register tokenizations
-- if the remaining length is 1 and the current char is . or $
-- if length xs == 1 then error undefinedelse do shit