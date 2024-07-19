module Main where 
import Instructions 
import Scanner

import Debug.Trace

main :: IO()
main = do
 
    let filePath = "test.mips" 
    file <- readFile filePath

    --print $ lines file

    let tokens = concatMap tokenize (lines file)

    -- let tokenst = map tokenize (lines file)

    print $ show tokens 

    print "FUCK"
    -- trace("TEST " ++ show tokens) (print $ tokens)
   -- print $ show tokens
--     map print test

--     mapM_ putStrLn linesOfFile 

