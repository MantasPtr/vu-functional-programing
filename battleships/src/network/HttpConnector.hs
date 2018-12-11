module HttpConnector(makeUrl, httpGet, httpPost) where 
    import Structures
    import Data.ByteString.Lazy.Char8 as LBString
    import Data.ByteString.Char8 as BString
    import Network.Wreq
    import Control.Lens
    import Network.HTTP.Types.Header

    baseUrl :: String
    baseUrl = "http://battleship.haskell.lt"

    makeUrl :: GameInfo -> String;
    makeUrl (NewGameInfo gameId player) = baseUrl ++ "/game/" ++ gameId ++ "/player/" ++ show player 

    httpGet :: String -> IO String
    httpGet url = do
        response <- getWith getHeaders url
        return $ LBString.unpack $ response ^. responseBody

    httpPost :: String -> String -> IO Int
    httpPost url body = do
        response <- postWith postHeaders url (BString.pack body)
        return $ (response ^. responseStatus) ^. statusCode

    getHeaders = defaults 
        & header hAccept .~ [BString.pack "application/json+nomaps"] 

    postHeaders = defaults & header hContentType .~ [BString.pack "application/json+nomaps"]
