module Main where 

-- import System.Console.ArgParser
import Scanner
import Parser

printLines :: Show a => [a] -> IO ()
printLines [] = return ()  
printLines (x:stream) = do
    putStrLn (show x) 
    printLines stream

main :: IO()
main = do
 
    file <- readFile "test.asm" 

    -- flat array of all tokens
    let tokenStream = filter (not . null) (map tokenize (lines file) )
    let code = map generateCode tokenStream

    --Parser will go here 
    -- let bytecode = Parser program tokenStream

    -- Later add if debug flag to print stream 
    putStrLn "Generated Code"
    printLines code
    
    putStrLn "Token Stream"
    printLines tokenStream

