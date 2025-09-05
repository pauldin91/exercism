module Isogram (isIsogram) where

import Data.Char (isLetter, isSpace,toLower)
import Data.List (nub)

isIsogram :: String -> Bool
isIsogram str
    | length (letters str) + length(nonLetters str) == length str = True
    | otherwise = False

letters str =  nub [toLower c | c <- str, isLetter c]
nonLetters str = [c | c <- str, not (isLetter c)]
