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

    -- Starting address of memory
    let startAddress = 0x010

    let tokenStream = filter (not . null) (map tokenize (lines file))

    let temp = map (assignMemory startAddress) tokenStream 

    -- Parse & generate code
    let parser = map parseMIPS temp

    putStrLn "\n\nToken Stream"
    printLines temp

    putStrLn "Generated Code"
    printLines parser

    putStrLn "\n\nSource File"
    putStrLn file

    writeFile "output.bin" (concat parser)


