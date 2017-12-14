module Day09 where

removeIgnoredCharacters :: String -> String
removeIgnoredCharacters [] = []
removeIgnoredCharacters [x] = [x]
removeIgnoredCharacters (a:b:xs)
    | a == '!' = removeIgnoredCharacters xs
    | otherwise = a: removeIgnoredCharacters (b:xs)
