module MessageConnector(postMessage, getMessage) where 

import Structures
import HttpConnector
import MessageParser
import Control.Monad
import Data.Either

postMessage :: Message -> GameInfo -> IO ()
postMessage message gameInfo = 
    do
        let url = makeUrl gameInfo
        let body = convertToJson message
        postCode <- httpPost url body
        when (postCode >= 300) $ fail "post fucked up" 

getMessage :: GameInfo -> IO Message
getMessage gameInfo = 
    do
        let url = makeUrl gameInfo
        responseStr <- httpGet url
        let eitherMessage = processMessageJson responseStr
        -- TODO error handling
        return $ head $ rights [eitherMessage]