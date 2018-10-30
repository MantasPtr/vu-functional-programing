module Demo where 
    a :: Either String String -> Either String String
    a b = do
        c <- b
        d <- Right "right"
        return d


 -- data ParseData = ParseData {
    --     msgLeft :: String
    --     messages :: Maybe Message
    -- }

    -- ["coord",["A","4"],"result",null,"prev",null]
    
    -- parse1 :: String -> ((String,String),String)
    -- parse1 msg =
    --     let 
    --         (letter, leftover1) = get_word $ skip_strings ["[", "\"coord\"", ",", "[", "\""] msg
    --         (number, leftover2) = get_number $ skip_strings ["\"", ",", "\""] leftover1
    --         leftover3 = skip_strings ["\"", "]", ","] leftover2
    --     in
    --         ((letter, number), leftover3)
    

    -- skip_strings:: [String] -> String -> String
    -- skip_strings listOfStrings msg = foldl skipString msg 
    

     -- get_start_while' :: (Char -> Bool) -> Either String String-> Either String (String, String) 
    -- get_start_while' check_func parseStringEihter = do
    --     parseString <- parseStringEither
    --     rez         <- get_start_while check_func parseString
    --     return rez

      -- get_word :: String -> (String, String)
    -- get_word s = get_start_while isLetter s
    -- get_number :: String -> (String, String)
    -- get_number s = get_start_while isDigit s

     -- skipString :: String -> String -> String
    -- skipString  msg s  =
    --     let 
    --         word_len = length s  
    --         next_word = take word_len msg
    --         leftover= drop word_len msg
    --     in 
    --         if next_word == s then leftover else msg



    