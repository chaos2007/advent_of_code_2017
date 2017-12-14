module TestDay09 where
    
    import Test.HUnit
    import Day09

    testRemovingUnusedCharacters1 :: Test
    testRemovingUnusedCharacters1 = 
        TestCase $ assertEqual "Should Remove Ignored characters" "<>" (removeIgnoredCharacters "<!>>")
    testRemovingUnusedCharacters2 :: Test
    testRemovingUnusedCharacters2 =         
        TestCase $ assertEqual "Should Remove Ignored characters" "<>" (removeIgnoredCharacters "<!!>")
    
    main :: IO Counts
    main = runTestTT $ TestList [testRemovingUnusedCharacters1, testRemovingUnusedCharacters2]