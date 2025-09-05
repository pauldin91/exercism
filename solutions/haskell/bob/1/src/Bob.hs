module Bob (responseFor) where

import Data.Char (isUpper, isLetter, isSpace)
import Data.List (dropWhileEnd)

responseFor :: String -> String
responseFor xs
    | null trimmed            = "Fine. Be that way!"
    | isQuestion && isShouting = "Calm down, I know what I'm doing!"
    | isShouting               = "Whoa, chill out!"
    | isQuestion               = "Sure."
    | otherwise                = "Whatever."
  where
    -- Trim leading and trailing whitespace
    trimmed     = dropWhileEnd isSpace (dropWhile isSpace xs)
    letters     = filter isLetter trimmed
    isQuestion  = not (null trimmed) && last trimmed == '?'
    isShouting  = not (null letters) && all isUpper letters
