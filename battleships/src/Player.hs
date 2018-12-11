module Player where 
import Structures
import MoveLogic
import MessageController
import MessageConnector
import MessageUtils( myShots, enemyShots)
import Data.List
import Data.Maybe

play:: String -> String -> IO String
play gameStr playerStr = do

    let player = getPlayer playerStr
    let gameInfo = NewGameInfo{gameId = gameStr, player = player}   
    case player of
        A -> makeFirstMove gameInfo
        B -> playB gameInfo
        

makeFirstMove :: GameInfo  -> IO (String)
makeFirstMove gameInfo = do 
    next <- nextHit
    let message = firstMessage next
    postMessage message gameInfo
    playB  gameInfo

playB :: GameInfo -> IO String
playB gameInfo = do
    retrievedMessage <- getMessage gameInfo
    maybe (return "Won") 
        ( \msg ->
            do
                let wasMyShipHit = wasHit msg
                let myGuesses = myShots retrievedMessage
                let myShipsLeftCount = myShipsLeft (enemyShots retrievedMessage)
                putStrLn $ "Already shot " ++ show (length myGuesses) ++" times. Still have: " ++ show myShipsLeftCount ++ " ships!"
                putStrLn "Already shot:"
                print myGuesses
                next <- nextHitSmart myGuesses
                putStrLn "Next short:"
                print next
                if myShipsLeftCount == 0  then 
                    do
                    let loseMsg = appendLostMessage wasMyShipHit retrievedMessage
                    postMessage loseMsg gameInfo
                    return "Lost"
                else
                    do 
                    let nextMove = appendMessage next wasMyShipHit retrievedMessage  
                    postMessage nextMove gameInfo
                    playB gameInfo)
        (coord retrievedMessage) 
