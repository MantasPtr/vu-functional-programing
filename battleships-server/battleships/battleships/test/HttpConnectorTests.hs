module HttpConnectorTests(httpConnectorTests) where

import Test.Tasty
import Test.Tasty.HUnit
import System.Random

import HttpConnector
import Structures


httpConnectorTests :: TestTree
httpConnectorTests = testGroup "Http connector tests" [
    testCase "Url creation player A" $
        makeUrl NewGameInfo {gameId="demo_game", player = A}  @?= 
            "http://battleship.haskell.lt/game/demo_game/player/A"
        ,
    testCase "Url creation player B" $
        makeUrl NewGameInfo {gameId="<script>console.log(1)<script>", player = B}  @?= 
            "http://battleship.haskell.lt/game/<script>console.log(1)<script>/player/B"
    ,
    testCase "Simple http post test" $
        do
            rez <- httpPost "http://httpbin.org/post" "undefin"
            let exp = 200
            if rez  == exp
            then return ()
            else assertFailure  $ "Test failure.\nExpected:\n" ++ show exp ++  "\nGot:\n"++ show rez
    ,
    testCase "Battleships http post test" $ 
        do
            randomPart <- randomIO:: IO Int
            let url = makeUrl NewGameInfo {gameId="id_that_does_not_ExIsT-" ++ show randomPart , player = A} 
            let demoData = "[\"coord\",[\"F\",\"6\"],\"result\",null,\"prev\",null]"
            rez <- httpPost url demoData
            let exp = 204
            if rez == exp
            then return ()
            else assertFailure  $ "Test failure.\nExpected:\n" ++ show exp ++  "\nGot:\n"++ show rez
    ,
    testCase "Post and get battleship" $
        do
            randomPart <- randomIO:: IO Int
            let urlA = makeUrl NewGameInfo {gameId="id_that_does_not_ExIsT-" ++ show randomPart , player = A} 
            let urlB = makeUrl NewGameInfo {gameId="id_that_does_not_ExIsT-" ++ show randomPart , player = B} 
            let demoData = "[\"coord\",[\"F\",\"6\"],\"result\",null,\"prev\",null]"
            httpPost urlA demoData
            rez <- httpGet urlB
            if rez  == demoData
            then return ()
            else assertFailure  $ "Test failure.\nExpected:\n" ++ show demoData ++  "\nGot:\n"++ show rez

    ]