module Main where 
    
import System.Exit ()
import Scanner ( tokenize, assignMemory )
import Parser ( parseMIPS )
import CLI ( Options(outputFile, sourceFile), optsParserInfo )
import Options.Applicative ( execParser )

printLines :: Show a => [a] -> IO ()
printLines [] = return ()  
printLines (x:stream) = do
    putStrLn (show x) 
    printLines stream

main :: IO()
main = do
 
    args <- execParser optsParserInfo

    file <- readFile (sourceFile args)

    -- Starting address of memory
    let startAddress = 0x010

    let tokenStream = filter (not . null) (map tokenize (lines file))

    let temp = map (assignMemory startAddress) tokenStream 

    -- Parse & generate code
    let parser = map parseMIPS temp


    putStrLn "\n\nToken Stream"
    printLines temp

    putStrLn "\n\nGenerated Code"
    printLines parser

    putStrLn "\n\nSource File"
    putStrLn file
  
    writeFile (outputFile args) (concat parser)


