module Main where 
import Instructions



test :: Instruction
test = IType{ op = ADD, rs = 1, rt = 2, immediate = 10 }

main :: IO()
main = do
    let test = IType{ op = ADD, rs = 1, rt = 2, immediate = 10 }
    putStrLn ("IType Instruction: " ++ show test)


