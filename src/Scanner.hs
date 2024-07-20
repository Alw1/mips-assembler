module Scanner where

import Data.Char (isDigit, isAlpha, isAlphaNum, isSpace)
import Instructions 

data Token =  LabelTok String
            | DirectiveTok String --Maybe(String) -- directive argument
            | OpcodeTok Opcode
            | RegisterTok Register
            | NumberTok String 
            -- | ShamtTok String
            -- | FunctTok String
            -- | AddressTok String
            -- | ImmediateTok String
            deriving(Show, Eq)

-- Creates a list of all tokens in a given line
tokenize :: String -> [Token]
tokenize [] = []
tokenize line@(x:xs)
    | isDigit x = tokenizeNumber line
    | null xs = []
    | isAlpha x = tokenizeOpcode line
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
                      in NumberTok num : tokenize line_tail

tokenizeDirective :: String -> [Token]
tokenizeDirective [] = []
tokenizeDirective str = let (dir, line_tail) = span isAlpha str
                        in DirectiveTok dir : tokenize line_tail
      
tokenizeLabel :: String -> [Token]
tokenizeLabel [] = []
tokenizeLabel str = let (label, line_tail) = span isAlphaNum str
                    in 
                        if head line_tail == ':' then
                            LabelTok label : tokenize(tail line_tail)
                        else
                            error "[Parse Error] Invalid label: " 
     
tokenizeOpcode :: String -> [Token]
tokenizeOpcode [] = []
tokenizeOpcode str = let (op, line_tail) = span isAlpha str
                     in OpcodeTok (toOpcode op) : tokenize line_tail

-- Add error checking in directive and register tokenizations
-- if the remaining length is 1 and the current char is . or $
-- if length xs == 1 then error else do shit