module Day09 where

removeIgnoredCharacters :: String -> String
removeIgnoredCharacters [] = []
removeIgnoredCharacters [x] = [x]
removeIgnoredCharacters (a:b:xs)
    | a == '!' = removeIgnoredCharacters xs
    | otherwise = a: removeIgnoredCharacters (b:xs)

removeGarbageStreams :: String -> String
removeGarbageStreams [] = []
removeGarbageStreams [x] = [x]
removeGarbageStreams (a:xs)
    | a == '<' = findEndingGarbageTag xs
    | otherwise = a : removeGarbageStreams xs

findEndingGarbageTag :: String -> String
findEndingGarbageTag [] = []
findEndingGarbageTag [x]
    | x == '>' = []
    | otherwise = [x]
findEndingGarbageTag (a:xs)
    | a == '>' = xs
    | otherwise = findEndingGarbageTag xs

cleanupStreams :: String -> String
cleanupStreams x = removeGarbageStreams (removeIgnoredCharacters x)
