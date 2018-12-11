module JsonParser where
    import Data.Char
    import Data.List
    
    parse1 :: String -> Either String ((String,String),String)
    parse1 msg = do
        skipped_beginning   <- skip_strings ["[", "\"coord\"", ",", "[", "\""] msg
        (letter, leftover1) <- get_word $ skipped_beginning
        skipped_separator   <- skip_strings ["\"", ",", "\""] leftover1
        (number, leftover2) <- get_number $ skipped_separator
        leftover3           <- skip_strings ["\"", "]", ","] leftover2
        return ((letter, number), leftover3)

    parse2 :: String -> Either String (Maybe Bool,String)
    parse2 msg = do
        skipped_beginning   <- skip_strings ["\"result\"", ","] msg
        (rez, leftover1)    <- match skipped_beginning
        leftover2           <- skip_strings [","] leftover1
        return (rez, leftover2)

    parse3 :: String -> Either String (Bool, String)
    parse3 msg = do
        skipped_beginning  <- skip_strings ["\"prev\"", ","] msg
        (prev, prevMsg)    <- Right $ if (startEquals skipped_beginning "null") then (False,"") else (True, skipped_beginning)
        return (prev, prevMsg)
    

    match :: String -> Either String (Maybe Bool, String)
    match str 
            | startEquals str "null" = Right (Nothing, drop 4 str) 
            | startEquals str "\"HIT\"" = Right  (Just True, drop 5 str)
            | startEquals str "\"MISS\"" = Right (Just False, drop 6 str)
            | otherwise = Left  $ "Unknown value:: " ++ str
     
    startEquals:: String -> String -> Bool
    startEquals msg word = takeWord word msg == word
        where
            takeWord:: String -> String -> String
            takeWord word fromString = take (length word) fromString

    skip_strings:: [String] -> String -> Either String String
    skip_strings listOfStrings msg =
        let
            either_msg = Right msg
            rez = foldl skipString either_msg listOfStrings
        in 
            rez
    
    skipString :: Either String String -> String -> Either String String
    skipString either_msg s = do
        msg <- either_msg
        rez <- skipStringE msg s
        return rez

    skipStringE :: String -> String -> Either String String
    skipStringE  msg s  =
        let 
            word_len = length s  
            next_word = take word_len msg
            leftover= drop word_len msg
        in 
            if next_word == s then Right leftover else Left $ "Wrong input. Expected starting with: '" ++ s ++ "'. Actual message = " ++ msg
            

    get_start_while :: (Char -> Bool) -> String -> (String, String) 
    get_start_while check_func parseString = (start, droppedStartString) 
        where 
            start :: String 
            start = takeWhile check_func parseString
            droppedStartString :: String
            droppedStartString =  drop (length start) parseString

    get_word :: String -> Either String (String, String)
    get_word s = Right $ get_start_while isLetter s
    get_number :: String -> Either String (String, String)
    get_number s = Right $ get_start_while isDigit s

