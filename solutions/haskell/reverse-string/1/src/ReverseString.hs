module ReverseString (reverseString) where

reverseString :: String -> String
reverseString [] = ""
reverseString str = reverseString(tail(str)) ++ [head(str)]
