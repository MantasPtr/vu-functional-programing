module Structures( Message(..), GameInfo(..),PlayerEnum(..), getPlayer) where

    data Message = NewMessage {
        coord :: Maybe (String, String) , 
        result :: Maybe Bool ,
        prev :: Maybe Message
    } deriving (Show, Eq)

    data GameInfo = NewGameInfo {
            gameId:: String,
            player:: PlayerEnum
        } deriving (Show, Eq)

    data PlayerEnum = A | B deriving (Show, Eq)


    getPlayer:: String -> PlayerEnum
    getPlayer player = case player of 
        "A" -> A
        "B" -> B 