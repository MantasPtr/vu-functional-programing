import ParserTests
import DemoTests
import HttpConnectorTests
import Test.Tasty

main :: IO ()
main = defaultMain tests

tests :: TestTree
tests = testGroup "Tests" [demoTests, parserTests, httpConnectorTests]
