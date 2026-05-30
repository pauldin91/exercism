module Acronym (abbreviate) where
import Data.Char (toUpper)
import Control.Monad (join)

abbreviate :: String -> String

abbreviate xs = [toUpper (head c) | c<- join ([words (scap (noncaps s)) | s <- words  (noap (map replace xs))])]
    where
        replace '-' = ' '
        replace ',' =  ' '
        replace '_' = ' '
        replace  c = c
        noap = filter (/= '\'')
        scap ss = join ([(\x -> if x == toUpper x then " " ++ [x] else [x]) s | s <- ss])

        noncaps ss = if map toUpper ss == ss then [head ss] else ss

