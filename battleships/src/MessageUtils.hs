module MessageUtils(messageToHits, myShots, getEverySecond,enemyShots) where 

import Structures
import Data.Maybe

messageToHits:: Message -> [((String,String), Bool)]
messageToHits msg = rez where
    coordM = coord msg
    hitM = result msg
    coordV = fromJust $ coord msg
    rez =  
        maybe  
            (maybe [] messageToHits (prev msg))
            (\hitV -> maybe [(coordV, hitV)] (\prevMsg->  (coordV, hitV) :  messageToHits prevMsg) (prev msg))   
            hitM

messageToHits2 :: Message -> [((String,String), Bool)]
messageToHits2 msg = rez where
    coordV = fromJust $ coord msg
    prevM = prev msg 
    rez = if isNothing prevM then
        [(coordV, True)]
    else
        (coordV, True) : messageToHits2 (fromJust prevM)


getEverySecond:: [a] -> [a]
getEverySecond (fst:snd:rest) = fst: getEverySecond rest
getEverySecond a = a

getEverySecondFrom2nd:: [a] -> [a]
getEverySecondFrom2nd (fst:snd:rest) = snd: getEverySecondFrom2nd rest
getEverySecondFrom2nd (fst:snd) = snd
getEverySecondFrom2nd _ = [] 


myShots:: Message -> [((String,String), Bool)]
myShots msg = getEverySecondFrom2nd $  messageToHits2 msg

enemyShots:: Message -> [(String,String)]
enemyShots msg = getEverySecond $ messageToMoves msg

messageToMoves:: Message -> [(String,String)]
messageToMoves msg = rez where
    coordM = coord msg
    coordV = fromJust $ coord msg
    rez =  maybe [coordV] (\prevMsg -> coordV:messageToMoves prevMsg) (prev msg)
            