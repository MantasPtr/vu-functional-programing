module Moves where

-- move :: String -> Either String (Maybe [String])
-- move msg = if checkIfGameOver msg then Right Nothing else move2 msg

-- move2 :: String -> Either String (Maybe [String])
-- move2 msg = do
--     pMsg <- process msg
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
