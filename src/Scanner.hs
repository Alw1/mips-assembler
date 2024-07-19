module Scanner where


import Data.Char (isDigit, isAlpha, isAlphaNum, isSpace)
import Instructions 

data Token =  LabelTok String
            | DirectiveTok String --Maybe(String) -- directive argument
            | OpcodeTok String -- Change back to Opcode later
            | RegisterTok String
            | NumberTok String 
            | ShamtTok String
            | FunctTok String
            | AddressTok String
            | ImmediateTok String
            | EOF
            deriving(Show)

-- Creates Token in a given line
tokenize :: String -> [Token]
tokenize line@(x:xs)
    | null line = []
    | isSpace x = tokenize xs -- ignores whitespace
    | x == '#' = tokenize [] -- ignore line if comment
    | x == '$' = tokenizeRegister xs
    | x == '.' = tokenizeDirective xs
    | isDigit x = tokenizeNumber line
    | isAlpha x = tokenizeOpcode line
    | otherwise = error $ "Unexpected input in line" ++ line

tokenizeRegister :: String -> [Token]
tokenizeRegister [] = []
tokenizeRegister line = let (register, line_tail) = span isAlphaNum line
                      in RegisterTok register : tokenize line_tail

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
tokenizeLabel str = let (num, line_tail) = span isAlphaNum str
                   in NumberTok num : tokenize line_tail
     
tokenizeOpcode :: String -> [Token]
tokenizeOpcode [] = []
tokenizeOpcode str = let (op, line_tail) = span isAlpha str
                    in OpcodeTok op: tokenize line_tail