module Main where 

-- import System.Console.ArgParser
import Scanner
import Parser


printTokens :: Show a => [a] -> IO ()
printTokens [] = return ()  
printTokens (x:stream) = do
    putStrLn (show x) 
    printTokens stream

main :: IO()
main = do
 
    file <- readFile "test.asm" 

    let tokenStream = concatMap tokenize (lines file) ++ [EOF]

    case parseMIPS file of
        Left err -> print err
        Right program -> print program

    -- Later add if debug flag to print stream
    putStrLn "Token Stream"
    printTokens tokenStream

