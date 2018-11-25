module HttpConnector(makeUrl) where 
    import Structures

    import Network.HTTP.Simple
    import Network.HTTP.Types.Header

    baseUrl :: String
    baseUrl = "http://battleship.haskell.lt"

    makeUrl :: GameInfo -> String;
    makeUrl (NewGameInfo gameId player) = baseUrl ++ "/game/" ++ gameId ++ "/player/" ++ show player 

    main :: IO ()
    main = do
        -- manager <- newManager defaultManagerSettings
    
        request <- parseRequest "GET http://httpbin.org/get"
        let contentTypeHeader = (hContentType, "application/json+nomaps")
        let requestWithHeaders = setRequestHeaders [contentTypeHeader] request
        response <- httpBS requestWithHeaders 
    
        putStrLn $ "The status code was: " ++ show (getResponseStatusCode response)
        print $ show $ getResponseBody response
