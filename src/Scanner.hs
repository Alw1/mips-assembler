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
    | null xs = []  --probably not needed
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
                      in NumberTok (read num) : tokenize line_tail

tokenizeDirective :: String -> [Token]
tokenizeDirective [] = []
tokenizeDirective str = let (dir, line_tail) = span isAlpha str
                        in DirectiveTok dir : tokenize line_tail
      
tokenizeLabel :: String -> [Token]
tokenizeLabel [] = []
tokenizeLabel str =  let (label, line_tail) = span isAlphaNum str
                     in 
                        if (not . null) line_tail && (not.isOpcode) label then 
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
                       

-- Transform labels and directives in memory addresses
-- NOTE: label memory addresses need to match all occurences of it, fix later
-- assignMemory ::  Int -> [Token] -> [Token]
-- assignMemory _ [] = []
-- assignMemory addr (x:xs) = case x of
--                       LabelTok _ -> MemoryTok (printf "%b" addr) : assignMemory (addr + size) xs
--                       DirectiveTok _ -> MemoryTok (printf "%b" addr) : assignMemory (addr + size) xs
--                       _ -> x : assignMemory addr xs 
--                       where
--                         size = 0x99 --Size of memory to be allocated

assignMemory ::  Int -> [Token] -> [Token]
assignMemory _ [] = []
assignMemory addr (x:xs) = case x of
                      LabelTok _ -> LabelTok (printf "%b" addr) : assignMemory (addr + size) xs
                      DirectiveTok _ -> DirectiveTok (printf "%b" addr) : assignMemory (addr + size) xs
                      _ -> x : assignMemory addr xs 
                      where
                        size = 0x99 --Size of memory to be allocated
                               
             
-- Add error checking in directive and register tokenizations
-- if the remaining length is 1 and the current char is . or $
-- if length xs == 1 then error undefinedelse do shit