module TestDay09 where
    
    import Test.HUnit
    import Day09

    testRemovingUnusedCharacters1 :: Test
    testRemovingUnusedCharacters1 = 
        TestCase $ assertEqual "Should Remove Ignored characters" "<>" (removeIgnoredCharacters "<!>>")
    testRemovingUnusedCharacters2 :: Test
    testRemovingUnusedCharacters2 =         
        TestCase $ assertEqual "Should Remove Ignored characters" "<>" (removeIgnoredCharacters "<!!>")
    testRemoveGarbageStream :: Test
    testRemoveGarbageStream =         
        TestCase $ assertEqual "Should Remove garbage stream" "" (removeGarbageStreams "<>")
    testCleanupStreams :: Test
    testCleanupStreams = 
        TestCase $ assertEqual "Should Remove everything." "" (cleanupStreams "<!>>")
    testCleanupStreams2 :: Test
    testCleanupStreams2 = 
        TestCase $ assertEqual "Should Remove everything." "" (cleanupStreams "<{o\"i!a,<{i<a>")    
    testCleanupStreams3 :: Test
    testCleanupStreams3 = 
        TestCase $ assertEqual "Should Remove everything." "{{},{},{},{}}" (cleanupStreams "{{<!!>},{<!!>},{<!!>},{<!!>}}")    

    
    
    main :: IO Counts
    main = runTestTT $ TestList [testRemovingUnusedCharacters1, testRemovingUnusedCharacters2, 
                                 testRemoveGarbageStream, testCleanupStreams, testCleanupStreams2, 
                                 testCleanupStreams3]