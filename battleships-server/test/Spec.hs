import ParserTests
import DemoTests
import HttpConnectorTests
import MoveTests
import MoveLogicTests
import MessageUtilsTests
import Test.Tasty

main :: IO ()
main = defaultMain tests

tests :: TestTree
tests = testGroup "Tests" [
    demoTests
    ,parserTests
    ,moveLogicTests
    ,messageUtilsTests
    -- ,moveTests
    -- ,httpConnectorTests
    ]