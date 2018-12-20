module MessageUtils(messageToHits, myShots, getEverySecond,enemyShots) where 

import Structures
import Data.Maybe

messageToHits:: Message -> [((String,String), Bool)]
messageToHits msg = rez where
    hitM = result msg
    rez =  
        maybe  
            []
                ( \hitV -> maybe []
                    (\prevMsg ->  (fromJust $ coord prevMsg, hitV) : messageToHits prevMsg) 
                    (prev msg)
                )   
            hitM

getEverySecond:: [a] -> [a]
getEverySecond (fst:snd:rest) = fst: getEverySecond rest
getEverySecond a = a

myShots:: Message -> [((String,String), Bool)]
myShots msg = getEverySecond $  messageToHits msg

enemyShots:: Message -> [(String,String)]
enemyShots msg = getEverySecond $ messageToMoves msg

messageToMoves:: Message -> [(String,String)]
messageToMoves msg = rez where
    coordM = coord msg
    coordV = fromJust $ coord msg
    rez =  maybe [coordV] (\prevMsg -> coordV:messageToMoves prevMsg) (prev msg)
            