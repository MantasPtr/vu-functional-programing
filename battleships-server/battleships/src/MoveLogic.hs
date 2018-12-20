module MoveLogic(shipLocations, nextHit, wasHit, myShipsLeft, nextHitSmart, nextHitNotRlSmart) where

import System.Random
import Data.List

shipLocations = [("A","1"),("A","2"),("A","3"),("A","4"),("C","1"),("C","2"),("C","3"),("C","5"),("C","6"),("C","7"),
    ("E","1"),("E","2"),("E","4"),("E","5"),("E","7"),("E","8"),("G","1"),("G","3"),("G","5"),("G","7")]

nextHit:: IO (String, String)
nextHit = do
    letter <- getStdRandom (randomR ('A','J')) 
    number <- getStdRandom (randomR ( 1:: Int,10)) 
    return ([letter], show number)

-- Shoots at random cell that has not been shot before
nextHitNotRlSmart:: [(String,String)] -> IO (String, String)
nextHitNotRlSmart prevShots = do
        randomShot <- nextHit
        if randomShot `elem ` prevShots then
            nextHitNotRlSmart prevShots
        else
            return randomShot

-- just argument mapping to nextHitNotRlSmart
nextHitSmart:: [((String,String),Bool)] -> IO (String, String)
nextHitSmart prevShots = nextHitNotRlSmart shotsWithoutStatus where
        shotsWithoutStatus = map fst prevShots

wasHit:: (String, String) -> Bool
wasHit shot = shot `elem` shipLocations

myShipsLeft:: [(String, String)] -> Int
myShipsLeft enemyGuesses = length $ shipLocations \\ enemyGuesses