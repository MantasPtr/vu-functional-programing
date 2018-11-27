module Lib( battle) where

import Player(play)
import Data.Maybe

battle :: IO ()
battle = do
    putStrLn "BATTLESHIPS"
    putStrLn "Were shall you fight?"
    gameId <- getLine
    putStrLn "Will you a player A or B?"
    name <- getLine
    result <- play gameId name
    putStrLn $ "Game over. Result:" ++ result