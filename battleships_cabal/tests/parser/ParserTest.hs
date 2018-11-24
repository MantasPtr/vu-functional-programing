module ParserTests (tests) where

import Test.Tasty

tests :: TestTree
tests = testGroup "Demo tests" [ testCase succeeds, testCase fails ]
  where
    succeed = "List comparison (different length)" $
        [1, 2, 3] `compare` [1, 2] @?= GT
    fails = "List comparison (same length)" $
        [1, 2, 3] `compare` [1, 2, 2] @?= LT 
