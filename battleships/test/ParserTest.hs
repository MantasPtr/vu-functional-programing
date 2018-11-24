module ParserTest(tests) where

import Test.Tasty
import Test.Tasty.HUnit

import Data.List
import Data.Ord

tests :: TestTree
tests = testGroup "Demo tests" 
    [
    testCase "List comparison (different length)" $
        [1, 2, 3] `compare` [1,2] @?= GT
    -- the following test does not hold
    ,
    testCase "List comparison (same length)" $
        [1, 2, 3] `compare` [1,2,2] @?= LT
    ]