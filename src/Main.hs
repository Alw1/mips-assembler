module Main where 
import Instructions


main :: IO()
main = do
 
    let test = [IType{ op = ADD, rs = 1, rt = 2, immediate = 10 },
                JType{ op = J, address = 102}]
   
    print test

--     let filePath = "tests/hello.asm" 

--     contents <- readFile filePath
--     let linesOfFile = lines contents

--     map print test

--     mapM_ putStrLn linesOfFile 

