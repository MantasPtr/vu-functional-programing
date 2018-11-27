module Player where 
import Structures
import Moves
import MessageController
import MessageConnector
import Data.List
import Data.Maybe

play:: String -> String -> IO String
play gameStr playerStr = do
    let myShips = shipLocations
    let player = getPlayer playerStr
    let gameInfo = NewGameInfo{gameId = gameStr, player = player}   
    case player of
        A -> makeFirstMove shipLocations gameInfo
        B -> playB shipLocations gameInfo
        

makeFirstMove :: [(String, String)] -> GameInfo  -> IO (String)
makeFirstMove shipLocations gameInfo = do 
    next <- nextHit
    let message = firstMessage next
    postMessage message gameInfo
    playB shipLocations gameInfo

playB :: [(String, String)] -> GameInfo -> IO String
playB myShips gameInfo = do
    retrieved <- getMessage gameInfo
    maybe (return "Won") ( \msg ->
        do
            let myShipsLeft = myShips \\ [msg]
            let wasMyShipHit = wasHit msg
            next <- nextHit
            if null myShipsLeft then 
                do
                let loseMsg = appendLostMessage wasMyShipHit retrieved
                postMessage loseMsg gameInfo
                return "Lost"
            else
                do 
                let nextMove = appendMessage next wasMyShipHit retrieved  
                postMessage nextMove gameInfo
                playB myShipsLeft gameInfo) (coord retrieved) 

    
    -- if isNothing (coord retrieved) then return "Won" else 
    --     do
    --         let myShipsLeft = myShips \\ coord retrieved
    --         let wasMyShipHit = wasHit $ coord retrieved
    --         next <- nextHit
    --         if null myShipsLeft then 
    --             do
    --             let loseMsg = appendLostMessage wasMyShipHit retrieved
    --             postMessage loseMsg gameInfo
    --             return "Lost"
    --         else
    --             do 
    --             let nextMove = appendMessage next wasMyShipHit retrieved  
    --             postMessage nextMove gameInfo
    --             playB myShipsLeft gameInfo