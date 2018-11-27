module Moves(shipLocations, nextHit, wasHit) where
    import System.Random

    shipLocations = [("A","1"),("A","2"),("A","3"),("A","4"),("C","1"),("C","2"),("C","3"),("C","5"),("C","6"),("C","7"),
        ("E","1"),("E","2"),("E","4"),("E","5"),("E","7"),("E","8"),("G","1"),("G","3"),("G","5"),("G","7")]

    nextHit:: IO (String, String)
    nextHit = do
        letter <- getStdRandom (randomR ('A','J')) 
        number <- getStdRandom (randomR ( 1:: Int,10)) 
        return ([letter], show number)

    wasHit:: (String, String) -> Bool
    wasHit shot = shot `elem`  shipLocations

-- move :: String -> Either String (Maybe [String])
-- move msg = if checkIfGameOver msg then Right Nothing else move2 msg

-- move2 :: String -> Either String (Maybe [String])
-- move2 msg = do
--     pMsg <- processMessageJson msg
--     return $ formatResultToRequirement $ getAvailableMoves $ getCurrentStepMoves $ splitToMoves $ fromJust pMsg


-- formatResultToRequirement :: [(String,String)] -> Maybe [String]
-- formatResultToRequirement moves = if null moves then Nothing else Just $ pairToList $ head moves
--         where 
--             pairToList :: (a,a) -> [a]
--             pairToList (a,b) = [a,b]

-- checkIfGameOver :: String -> Bool 
-- checkIfGameOver msg = startEquals msg "[\"coord\",[]" 

-- splitToMoves:: Message -> ([Maybe (String,String)],[Maybe (String,String)])
-- splitToMoves msg = if isNothing previous then ([msgCoord], []) else (msgCoord: snd getPrev, fst getPrev)
--     where
--         previous:: Maybe Message
--         previous = prev msg
--         msgCoord:: Maybe (String, String)
--         msgCoord = coord msg
--         getPrev:: ([Maybe (String,String)],[Maybe (String,String)])
--         getPrev = splitToMoves (fromJust previous)

-- getCurrentStepMoves :: ([a],[a]) -> [a]
-- getCurrentStepMoves (movesA, movesB) =  if length movesA < length movesB then movesA else movesB

-- getAvailableMoves :: [(String,String)] -> [(String,String)]
-- getAvailableMoves moves = allMoves \\ moves
--     where 
--         allMoves:: [(String,String)] 
--         allMoves = [([l],show n) | l <- ['A'..'J'], n <- [1..10]]
