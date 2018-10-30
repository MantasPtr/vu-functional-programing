-- module TestProgram where 
--     add :: Integer -> Integer -> Integer
--     add a b = a * b
--     putStrLn "hi"
main = do putStrLn "What is 2 + 2?"
          x <- readLn
          if parse a
              then putStrLn "Valid input"
              else putStrLn "Invalid input"


parse :: String -> Bool
parse inp = False