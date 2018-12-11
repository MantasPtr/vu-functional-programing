module Lib( battle) where

import Player(play)
import Data.Maybe

battle :: IO ()
battle = do
    putStrLn "BATTLESHIPS"
    gameId <- readGameId
    name <- readUserName
    result <- play gameId name
    putStrLn $ "Game over. Result:" ++ result

readUserName :: IO String
readUserName = do
    putStrLn "Will you a player A or B?"
    name <- getLine
    if (name == "A") || (name == "B") then
        return name
    else
        do
            putStrLn "Thats not a valid user name"
            readUserName

readGameId :: IO String
readGameId = do
    putStrLn "Were shall you fight?"
    gameId <- getLine
    if gameId /= "" && elem '/' gameId then
        do
            putStrLn "Thats not a valid game Id"
            readGameId
    else
        return gameId
          