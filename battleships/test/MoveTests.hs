module MoveTests(moveTests) where 

import Test.Tasty
import Test.Tasty.HUnit
import Data.Maybe

import MessageController
import MessageConnector
import HttpConnector(makeUrl)
import System.Random
import Structures

moveTests :: TestTree
moveTests = testGroup "High level move tests" [
    testCase "First move" $
    do 
        gameName <- gameNameGen 
        let gameInfoA = gameInfoGen gameName A
        let gameInfoB = gameInfoGen gameName B
        let message = firstMessage ("A","1")
        postMessage message gameInfoA
        retrieved <- getMessage gameInfoB
        if retrieved == message
            then return ()
            else assertFailure  $ "Test failure.\nExpected:\n" ++ show message ++  "\nGot:\n"++ show retrieved
    ,
    testCase "Second move" $
    do 
        gameName <- gameNameGen 
        let gameInfoA = gameInfoGen gameName A
        let gameInfoB = gameInfoGen gameName B
        let message1 = firstMessage ("A","1")
        postMessage message1 gameInfoA
        retrieved1 <- getMessage gameInfoB
        let message2 = appendMessage ("B","2") False retrieved1
        postMessage message2 gameInfoB
        retrieved2 <- getMessage gameInfoA
        if retrieved2 == message2
            then return ()
            else assertFailure  $ "Test failure.\nExpected:\n" ++ show message2 ++  "\nGot:\n"++ show retrieved2
    ]

gameNameGen::  IO String
gameNameGen = 
    do
    randomPart <- randomIO :: IO Int
    return $ "nnnnneeewwwwww" ++ show randomPart

gameInfoGen:: String -> PlayerEnum -> GameInfo
gameInfoGen url player = NewGameInfo {gameId=url, player = player}