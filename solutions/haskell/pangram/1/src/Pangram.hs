module Pangram (isPangram) where

import Data.Char (toLower, isAlpha, ord)
import Data.List (nub)

isPangram :: String -> Bool
isPangram text =
  length (nub [toLower c | c <- text, isAlpha c, ord c <=127]) == 26
