module Main where 
import Instructions 
import Scanner

main :: IO()
main = do
 
    let test = [IType{ op = ADD, rs = 1, rt = 2, immediate = 10 },
                JType{ op = J, address = 102}]
   
    let testTok = ".directive $A0 $B1 $FUCK #DONT TAKE THIS"

    let tokens = tokenize testTok

    print tokens

--     let filePath = "tests/hello.asm" 

--     contents <- readFile filePath
--     let linesOfFile = lines contents

--     map print test

--     mapM_ putStrLn linesOfFile 

