module Structures where

    data Message = Message {
            coord :: (String, String) , 
            result :: Maybe Bool ,
            prev :: Maybe Message
        } 
        deriving Show