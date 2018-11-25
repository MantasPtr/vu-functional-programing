module DemoTests(demoTests) where

    import Test.Tasty
    import Test.Tasty.HUnit
    
    import Data.List
    import Data.Ord
    
    demoTests :: TestTree
    demoTests = testGroup "Demo tests" 
        [
        testCase "List comparison (different length)" $
            [1, 2, 3] `compare` [1,2] @?= GT
        ,
        testCase "List comparison (same length)" $
            [1, 2, 3] `compare` [1,2,3] @?= EQ
        ]