module TestDay09 where
    
    import Test.HUnit
    import System.IO.Unsafe
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
    testScoringStreams1 :: Test
    testScoringStreams1 = 
        TestCase $ assertEqual "Should score stream." 1 (scoreStream "{}")
    testScoringStreams2 :: Test
    testScoringStreams2 = 
        TestCase $ assertEqual "Should score stream." 6 (scoreStream "{{{}}}")
    testScoringStreams3 :: Test
    testScoringStreams3 = 
        TestCase $ assertEqual "Should score stream." 9 (scoreStream "{{<!!>},{<!!>},{<!!>},{<!!>}}")
    testScoringStreams5 :: Test
    testScoringStreams5 = 
        TestCase $ assertEqual "Should score stream." 16 (scoreStream "{{{},{},{{}}}}")
    testScoringStreams6 :: Test
    testScoringStreams6 = 
        TestCase $ assertEqual "Should score stream." 1 (scoreStream "{<a>,<a>,<a>,<a>}")
    testScoringStreams7 :: Test
    testScoringStreams7 = 
        TestCase $ assertEqual "Should score stream." 3 (scoreStream "{{<a!>},{<a!>},{<a!>},{<ab>}}")
    testCleanupStreams7 :: Test
    testCleanupStreams7 = 
        TestCase $ assertEqual "Should score stream." "{{}}" (cleanupStreams "{{<a!>},{<a!>},{<a!>},{<ab>}}")
    testScoringStreams8 :: Test
    testScoringStreams8 = 
        TestCase $ assertEqual "Should score stream." 1 (scoreStream "{<{},{},{{}}>}")
    testCleanupStreams4 :: Test
    testCleanupStreams4 = 
        TestCase $ assertEqual "Should score stream." "" (cleanupStreams (unsafePerformIO . readFile $ "test_pattern.txt" ))
    testScoringStreams4 :: Test
    testScoringStreams4 = 
        TestCase $ assertEqual "Should score stream." 11898 (scoreStream (unsafePerformIO . readFile $ "test_pattern.txt" ))
    testCountGarbageStream1 :: Test
    testCountGarbageStream1 = 
        TestCase $ assertEqual "Should count garbage." 0 (countGarbageStream "<>")
    testCountGarbageStream2 :: Test
    testCountGarbageStream2 = 
        TestCase $ assertEqual "Should count garbage." 17 (countGarbageStream "<random characters>")
    testCountGarbageStream3 :: Test
    testCountGarbageStream3 = 
        TestCase $ assertEqual "Should count garbage." 3 (countGarbageStream "<<<<>")
    testCountGarbageStream4 :: Test
    testCountGarbageStream4 = 
        TestCase $ assertEqual "Should count garbage." 2 (countGarbageStream "<{!>}>")
    testCountGarbageStream5 :: Test
    testCountGarbageStream5 = 
        TestCase $ assertEqual "Should count garbage." 0 (countGarbageStream "<!!>")
    testCountGarbageStream6 :: Test
    testCountGarbageStream6 = 
        TestCase $ assertEqual "Should count garbage." 0 (countGarbageStream "<!!!>>")
    testCountGarbageStream7 :: Test
    testCountGarbageStream7 = 
        TestCase $ assertEqual "Should count garbage." 10 (countGarbageStream "<{o\"i!a,<{i<a>")
    testCountGarbageStream8 :: Test
    testCountGarbageStream8 = 
        TestCase $ assertEqual "Should score stream." 5601 (countGarbageStream (unsafePerformIO . readFile $ "test_pattern.txt" ))
    testCountGarbageStream9 :: Test
    testCountGarbageStream9 = 
        TestCase $ assertEqual "Should score stream." "" (createGarbageStream (removeIgnoredCharacters (unsafePerformIO . readFile $ "test_pattern.txt" )))
    testCountGarbageStream10 :: Test
    testCountGarbageStream10 = 
        TestCase $ assertEqual "Should count garbage." "abababab" (createGarbageStream (removeIgnoredCharacters "{{<ab>},{<ab>},{<ab>},{<ab>}}"))
    
    
    
    main :: IO Counts
    main = runTestTT $ TestList [testRemovingUnusedCharacters1, testRemovingUnusedCharacters2, 
                                 testRemoveGarbageStream, testCleanupStreams, testCleanupStreams2, 
                                 testCleanupStreams3, testScoringStreams1, testScoringStreams2,
                                 testScoringStreams3, testScoringStreams4, testScoringStreams5,
                                 testScoringStreams6, testScoringStreams7,
                                 testScoringStreams8, testCleanupStreams7, testCountGarbageStream1,
                                 testCountGarbageStream2, testCountGarbageStream3, testCountGarbageStream4,
                                 testCountGarbageStream5, testCountGarbageStream6, testCountGarbageStream7,
                                 testCountGarbageStream8, testCountGarbageStream10]