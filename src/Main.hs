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

    -- flat array of all tokens
    let tokenStream = map tokenize (lines file) 

    let code = map generateCode tokenStream

    putStrLn "Generated Code"
    printTokens code

    -- Parser starting at first production
    -- let parser = parseMIPS tokenStream

    -- let bytecode = case parser of
    --                 Right err -> print err
    --                 Left program -> print program
    -- -- in 
    --     print bytecode

    -- Later add if debug flag to print stream
    putStrLn "Token Stream"
    printTokens tokenStream

