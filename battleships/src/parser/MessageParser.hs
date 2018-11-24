module MessageParser where 
    import Data.List
    import Data.Maybe
    import JsonParser
    data Message = Message {
            coord :: (String, String) , 
            result :: Maybe Bool ,
            prev :: Maybe Message
        } 
        deriving Show


    move :: String -> Either String (Maybe [String])
    move msg = if checkIfGameOver msg then Right Nothing else move2 msg

    move2 :: String -> Either String (Maybe [String])
    move2 msg = do
        pMsg <- process msg
        return $ formatResultToRequirement $ getAvailableMoves $ getCurrentStepMoves $ splitToMoves $ fromJust pMsg
    process :: String -> Either String (Maybe Message)
    process msg = do
        (coordinates, leftover1)    <- parse1 msg
        (hitMiss, leftover2)        <- parse2 leftover1
        (prevExist, leftover)       <- parse3 leftover2
        prev                        <- if prevExist then process leftover else Right Nothing
        return $ Just Message {coord = coordinates, result = hitMiss, prev = prev}

    splitToMoves:: Message -> ([(String,String)],[(String,String)])
    splitToMoves msg = if isNothing previous then ([msgCoord], []) else (msgCoord: snd getPrev, fst getPrev)
        where
            previous:: Maybe Message
            previous = prev msg
            msgCoord:: (String, String)
            msgCoord = coord msg
            getPrev:: ([(String,String)],[(String,String)])
            getPrev = splitToMoves (fromJust previous)

    getCurrentStepMoves :: ([a],[a]) -> [a]
    getCurrentStepMoves (movesA, movesB) =  if length movesA < length movesB then movesA else movesB

    getAvailableMoves :: [(String,String)] -> [(String,String)]
    getAvailableMoves moves = allMoves \\ moves
        where 
            allMoves:: [(String,String)] 
            allMoves = [([l],show n) | l <- ['A'..'J'], n <- [1..10]]

    formatResultToRequirement :: [(String,String)] -> Maybe [String]
    formatResultToRequirement moves = if null moves then Nothing else Just $ pairToList $ head moves
            where 
                pairToList :: (a,a) -> [a]
                pairToList (a,b) = [a,b]
    
    checkIfGameOver :: String -> Bool 
    checkIfGameOver msg = startEquals msg "[\"coord\",[]" 
    
    -- splitToPlayers:: Message -> (Maybe Message,Maybe Message) -- -> (Maybe Message,Maybe Message)
    -- splitToPlayers msg = if isNothing previous then (Just msg,Nothing) else (Just msg {prev = snd (splitToPlayers (fromJust previous))}, fst (splitToPlayers (fromJust previous)))
    --     where
    --         previous:: Maybe Message
    --         previous = prev msg

            
    -- trimBefore :: String -> String
    -- trimBefore s = snd $ get_start_while isSpace s

   