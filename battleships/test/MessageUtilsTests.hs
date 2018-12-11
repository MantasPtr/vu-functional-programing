module MessageUtilsTests(messageUtilsTests) where

import Test.Tasty
import Test.Tasty.HUnit
import Structures
import MessageUtils

messageUtilsTests :: TestTree
messageUtilsTests = testGroup "Message Utils tests"  [messageToHitsTests, getEverySecondTests,enemyShotsTests, myShotsTests]


messageToHitsTests = testGroup "Functions messageToHits tests" 
    [
    testCase "2 message to hits" $
        messageToHits NewMessage {coord = Just ("E","5"), result = Just True, prev = Just NewMessage {coord = Just ("F","6"), result = Nothing, prev = Nothing} } @?= 
            [(("F","6"), True)]
    ,
    testCase "3 message to hits order" $
        messageToHits NewMessage {coord = Just ("F","1"), result = Just False, prev = Just NewMessage {coord = Just ("F","2"), result = Just True, prev = Just NewMessage {coord = Just ("F","3"), result = Nothing, prev = Nothing}} } @?= 
            [(("F","2"), False) , (("F","3"), True)]
    ,
    testCase "first message to hits" $
        messageToHits NewMessage {coord = Just ("A","1"), result = Nothing, prev = Nothing} @?= 
            []
    ]

getEverySecondTests = testGroup "Functions getEverySecond tests" 
    [
    testCase "1 move" $
        getEverySecond [(("F","6"), True)] @?= 
            [(("F","6"), True)]
    ,
    testCase "2 move" $
        getEverySecond [(("A","1"), True),(("A","2"), True)] @?= 
        [(("A","1"), True)]
    ,
    testCase "3 move" $
        getEverySecond [(("A","1"), True),(("A","2"), True),(("A","3"), True)] @?= 
            [(("A","1"),True),(("A","3"), True)]
    ,
    testCase "4 move" $
    getEverySecond [(("A","1"), True),(("A","2"), True),(("A","3"), True),(("A","4"), True)] @?= 
        [(("A","1"),True),(("A","3"), True)]
    ]

myShotsTests = testGroup "Functions myShots tests" 
    [
    testCase "first message shots" $
        myShots NewMessage {coord = Just ("A","1"), result = Nothing, prev = Nothing} @?= 
            []
    ,
    testCase "first and second message shots" $
        myShots NewMessage {coord = Just ("A","1"), result = Just True, prev = Just NewMessage {coord = Just ("A","2"), result = Nothing, prev = Nothing}} @?= 
            [(("A","2"),True)]
    ,
    testCase "3 message shots" $
        myShots NewMessage {coord = Just ("A","1"), result = Just True, prev = Just NewMessage {coord = Just ("A","2"), result = Just True, prev = Just NewMessage {coord = Just ("A","3"), result = Nothing, prev = Nothing}}} @?= 
            [(("A","2"),True)]
    ,
    testCase "4 message shots" $
        myShots NewMessage {coord = Just ("A","1"), result = Just True, prev = Just NewMessage {coord = Just ("A","2"), result = Just True, prev = Just NewMessage {coord = Just ("A","3"), result = Just False, prev = Just NewMessage {coord = Just ("A","4"), result = Nothing, prev = Nothing}}}} @?= 
            [(("A","2"),True),(("A","4"),False)]
    , 
    testCase "5 message shots" $
        myShots NewMessage {coord = Just ("A","1"), result = Just True, prev = Just NewMessage {coord = Just ("A","2"), result = Just True, prev = Just NewMessage {coord = Just ("A","3"), result = Just True, prev = Just NewMessage {coord = Just ("A","4"), result = Just True, prev = Just NewMessage {coord = Just ("A","5"), result = Just True, prev = Nothing}}}}} @?= 
            [(("A","2"),True),(("A","4"),True)]
    ]


enemyShotsTests = testGroup "Functions enemyShots tests" 
    [
    testCase "first message shots" $
        enemyShots NewMessage {coord = Just ("A","1"), result = Nothing, prev = Nothing} @?= 
            [("A","1")]
    ,
    testCase "first and second message shots" $
        enemyShots NewMessage {coord = Just ("A","1"), result = Just True, prev = Just NewMessage {coord = Just ("A","2"), result = Nothing, prev = Nothing }} @?= 
            [("A","1")]
    ,
    testCase "3 message shots" $
        enemyShots NewMessage {coord = Just ("A","1"), result = Just True, prev = Just NewMessage {coord = Just ("A","2"), result = Just True, prev = Just NewMessage {coord = Just ("A","3"), result = Nothing, prev = Nothing}}} @?= 
            [("A","1"),("A","3")]
    ,
    testCase "4 message shots" $
    enemyShots NewMessage {coord = Just ("A","1"), result = Just True, prev = Just NewMessage {coord = Just ("A","2"), result = Just True, prev = Just NewMessage {coord = Just ("A","3"), result = Just True, prev = Just NewMessage {coord = Just ("A","4"), result = Nothing, prev = Nothing}}}} @?= 
            [("A","1"),("A","3")]
    , 
    testCase "5 message shots" $
    enemyShots NewMessage {coord = Just ("A","1"), result = Just True, prev = Just NewMessage {coord = Just ("A","2"), result = Just True, prev = Just NewMessage {coord = Just ("A","3"), result = Just True, prev = Just NewMessage {coord = Just ("A","4"), result = Just True, prev = Just NewMessage {coord = Just ("A","5"), result = Nothing, prev = Nothing}}}}} @?= 
            [("A","1"),("A","3"),("A","5")]
    ]
