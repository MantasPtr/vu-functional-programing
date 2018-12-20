module MessageParser where 
import Data.List
import Data.Maybe
import JsonParser
import Structures

processMessageJson :: String -> Either String Message
processMessageJson msg = do
    (coordinates, hitMiss, prevExist, leftover )    <- performParsing msg
    prev                        <- if prevExist then maybeProcessMessageJson leftover else Right Nothing
    return NewMessage {coord = coordinates, result = hitMiss, prev = prev}

maybeProcessMessageJson :: String -> Either String (Maybe Message)
maybeProcessMessageJson msg = do
    (coordinates, hitMiss, prevExist, leftover )    <- performParsing msg
    prev                                            <- if prevExist then maybeProcessMessageJson leftover else Right Nothing
    return $ Just NewMessage {coord = coordinates, result = hitMiss, prev = prev}

performParsing :: String -> Either String (Maybe (String,String), Maybe Bool, Bool, String)
performParsing msg =  do
    (coordinates, leftover1)    <- parse1 msg
    (hitMiss, leftover2)        <- parse2 leftover1
    (prevExist, leftover)       <- parse3 leftover2
    return (coordinates, hitMiss, prevExist, leftover)

convertToJson :: Message -> String
convertToJson msg = rez 
    where
        coordStr :: String
        coordStr = maybe "[]" (\(a,b) -> "[\"" ++ a ++ "\",\"" ++ b ++ "\"]") (coord msg)
        resultStr = maybe "null" (\a -> if a then "\"HIT\"" else "\"MISS\"") (result msg)
        messageStr = maybe "null" convertToJson (prev msg)
        rez = "[\"coord\"," ++ coordStr ++ ",\"result\"," ++ resultStr ++ ",\"prev\","++ messageStr ++ "]" 