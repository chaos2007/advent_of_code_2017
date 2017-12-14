module TestDay09 where
    
    import Test.HUnit
    import Day09
    
    testSafeHeadForEmptyList :: Test
    testSafeHeadForEmptyList = 
        TestCase $ assertEqual "Should return Nothing for empty list"
                               1 1
    
    testSafeHeadForNonEmptyList :: Test
    testSafeHeadForNonEmptyList =
        TestCase $ assertEqual "Should return (Just head) for non empty list" 1
                   2
    
    main :: IO Counts
    main = runTestTT $ TestList [testSafeHeadForEmptyList, testSafeHeadForNonEmptyList]