module MoveLogicTests(moveLogicTests) where 

import Test.Tasty
import Test.Tasty.HUnit
import MoveLogic

import Text.Read
import Data.Maybe
import Data.List

moveLogicTests :: TestTree
moveLogicTests = testGroup "Move logic test" [
    testCase "Is letter" $
    do 
        (hitLetterStr, _) <- nextHit
        length hitLetterStr @?= 1
    ,
    testCase "Is number" $
    do 
        (_, hitNumberStr) <- nextHit 
        let maybeInt = readMaybe hitNumberStr :: Maybe Int
        isJust maybeInt @?= True
    ,
    testCase "Is valid letter" $
    do 
        (hitLetterStr, _) <- nextHit
        let letter = head hitLetterStr
        validLetter letter @?= True
    ,
    testCase "Is valid number" $
        do 
            (_, hitNumberStr) <- nextHit 
            let number = read hitNumberStr
            validNumber number @?= True
    ,
    testCase "100 valid moves" $
        do 
            moves <- getMoves 100
            all validMove moves @?= True
    ,
    testCase "100 unique moves" $
        do 
            moves <- getMoves 100
            length (nub moves) @?= length moves
    ]
    

getMoves :: Int -> IO [(String,String)]
getMoves count 
    | count < 1 = return []
    | count == 1 =
                    do
                        move <- nextHitSmart []
                        return [move]
    | otherwise =
                    do
                    moreMoves <- getMoves (count-1)
                    move <- nextHitNotRlSmart moreMoves
                    return $ move : moreMoves

validLetter :: Char -> Bool
validLetter letter = letter >= 'A' && letter <= 'J'

validNumber :: Int -> Bool
validNumber number =  number >= 1 && number <= 10

parse:: (String, String) -> (Char, Int)
parse (charStr, numberStr) = (head charStr, read numberStr)

validMove :: (String, String) -> Bool
validMove moveStr = rez where 
    (letter,number) = parse moveStr
    rez = validLetter letter && validNumber number
