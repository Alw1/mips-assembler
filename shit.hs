-- Define the function to print each token in a list
printTokens :: Show a => [a] -> IO ()
printTokens [] = return ()  -- Base case: do nothing for an empty list
printTokens (x:stream) = do
    putStrLn (show x)       -- Print the current element
    printTokens stream      -- Recursively process the rest of the list

-- Example usage
main :: IO ()
main = printTokens [1, 2, 3, 3, 4]