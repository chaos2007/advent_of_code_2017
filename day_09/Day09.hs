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
    | a == '<' = removeGarbageStreams (findEndingGarbageTag xs)
    | otherwise = a : removeGarbageStreams xs

findEndingGarbageTag :: String -> String
findEndingGarbageTag [] = []
findEndingGarbageTag [x]
    | x == '>' = []
    | otherwise = [x]
findEndingGarbageTag (a:xs)
    | a == '>' = xs
    | otherwise = findEndingGarbageTag xs

countGarbageStream :: String -> Int
countGarbageStream x = length (createGarbageStream (removeIgnoredCharacters x))

createGarbageStream :: String -> String
createGarbageStream x = x

cleanupStreams :: String -> String
cleanupStreams x = removeGarbageStreams (removeIgnoredCharacters x)

scoreStream :: String -> Int
scoreStream x = scoreStream' (cleanupStreams x ) 0 0

scoreStream' :: String -> Int -> Int -> Int
scoreStream' [] acc level = acc
scoreStream' [x] acc level
    | x == '}' = acc + level
    | otherwise = acc
scoreStream' (x:xs) acc level
    | x == '{' = scoreStream' xs acc (level + 1)
    | x == '}' = scoreStream' xs (acc+level) (level - 1)
    | otherwise = scoreStream' xs acc level


