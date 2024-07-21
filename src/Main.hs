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

    print file
    -- Starting address of memory
    let startAddress = 0x000

    let tokenStream = filter (not . null) (map tokenize (lines file))

    let temp = assignMemory (concat tokenStream) startAddress

    --let code = generateCode temp

    let parser = parseMIPS temp

    -- --Parser will go here 
    -- -- let bytecode = Parser program tokenStream

    -- -- Later add if debug flag to print stream 

    putStrLn "\n\nToken Stream"
    printLines (tokenStream)

    putStrLn "Generated Code"
    print parser

    putStrLn "\n\nSource File"
    putStrLn file

    -- writeFile "output.bin" parser  


