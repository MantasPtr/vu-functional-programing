module MessageParser where 
    import Data.List
    import Data.Maybe
    import JsonParser
    import Structures

    process :: String -> Either String (Maybe Message)
    process msg = do
        (coordinates, leftover1)    <- parse1 msg
        (hitMiss, leftover2)        <- parse2 leftover1
        (prevExist, leftover)       <- parse3 leftover2
        prev                        <- if prevExist then process leftover else Right Nothing
        return $ Just NewMessage {coord = coordinates, result = hitMiss, prev = prev}

   