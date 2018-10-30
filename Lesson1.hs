module Lesson1 where
    var:: Integer
    var = 42
    add :: Integer -> Integer -> Integer
    add a b = a + b 
    other :: Integer -> Integer -> Integer
    other = f 1
        where
            f :: Integer -> Integer -> Integer -> Integer
            f a b c = b + c
    other2 :: Integer -> Integer
    other2 a = 
        let 
            b = 1
            c = 2
        in
            a + b + c 
    i :: Integer -> Bool
    i a = if a <= 10 then True else False
    str :: [Char]
    str = "Support"
    str1 = [4]
    str2 = 3: str1
    len :: [a] -> Integer
    len [] = 0
    len (_: t) = 1 + len t 
    

    