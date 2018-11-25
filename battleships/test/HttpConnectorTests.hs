module HttpConnectorTests(httpConnectorTests) where

import Test.Tasty
import Test.Tasty.HUnit

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
    ]