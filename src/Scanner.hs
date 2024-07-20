module Scanner where

import Data.Char (isDigit, isAlpha, isAlphaNum, isSpace)
import Instructions 
import Text.Printf (printf)

data Token =  LabelTok String
            | DirectiveTok String --Maybe(String) -- directive argument
            | OpcodeTok Opcode
            | RegisterTok Register
            | NumberTok Int
            | MemoryTok String -- Not used in scanning, used in assigning address to directives and labels 
            deriving(Show, Eq)

-- Creates a list of all tokens in a given line
tokenize :: String -> [Token]
tokenize [] = []
tokenize line@(x:xs)
    | isDigit x = tokenizeNumber line
    | isAlpha x = tokenizeLabel line
    | isSpace x || x == ',' = tokenize xs -- ignores whitespace & commas
    | x == '#' = tokenize []              -- ignore line if its a comment
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
                      in NumberTok  (read num) : tokenize line_tail

tokenizeDirective :: String -> [Token]
tokenizeDirective [] = []
tokenizeDirective str = let (dir, line_tail) = span isAlpha str
                        in DirectiveTok dir : tokenize line_tail
      
tokenizeLabel :: String -> [Token]
tokenizeLabel [] = []
tokenizeLabel str =  let (label, line_tail) = span isAlphaNum str
                     in 
                     if (not . null) line_tail && head line_tail == ':' then 
                        LabelTok label : tokenize (tail line_tail)
                     else 
                        tokenizeOpcode str 

tokenizeOpcode :: String -> [Token]
tokenizeOpcode [] = []
tokenizeOpcode str = let (op, line_tail) = span isAlpha str
                     in OpcodeTok (toOpcode op) : tokenize line_tail


-- Transform labels and directives in memory addresses
assignMemory :: [Token] -> Int -> [Token]
assignMemory [] _ = []
assignMemory (x:xs) addr = case x of
                      LabelTok a -> MemoryTok (printf "%b" addr) : assignMemory xs (addr + size)
                      DirectiveTok a -> MemoryTok (printf "%b" addr) : assignMemory xs (addr + size)
                      _ -> x : assignMemory xs addr
                      where
                        size = 0x10 --Size of memory to be allocated
             

-- Add error checking in directive and register tokenizations
-- if the remaining length is 1 and the current char is . or $
-- if length xs == 1 then error else do shit