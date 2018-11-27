import ParserTests
import DemoTests
import HttpConnectorTests
import MoveTests
import Test.Tasty

main :: IO ()
main = defaultMain tests

tests :: TestTree
tests = testGroup "Tests" [
    demoTests
    ,parserTests
    -- ,moveTests
    -- ,httpConnectorTests

    ]