module Lesson2 where
    import Data.List
    import Data.Char
    f :: [Integer] -> Integer
    f = foldl (*) 1

    parseStr :: String -> (String, String)
    parseStr msg = readStr len $ drop (length lenghtAsStr) msg
        where
            lenghtAsStr = takeWhile isDigit msg
            len :: Int
            len = read lenghtAsStr
            readStr :: Int -> String -> (String, String)
            readStr n (':':m) = (take n m, drop n m)
            readStr a b = error ("Colon expected. Got: " ++ show a ++ " "  ++ b)
    
    parseStringList :: String -> ([String], String)
    parseStringList ('[':m) = parseElement m []
        where
        parseElement (']':l) acc = (reverse acc, l)
        parseElement z acc =
            let
                (r, l) = parseStr z 
            in
                parseElement l (r:acc)
    parseStringList _ = error "Square bracket expected"
            

    data Msg = MsgDict [(String, Msg)] 
            | MsgList [Msg]
            | MsgString String
        deriving Show
