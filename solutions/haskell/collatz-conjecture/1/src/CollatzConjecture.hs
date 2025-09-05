module CollatzConjecture (collatz) where

collatz :: Integer -> Maybe Integer
collatz n
  | n <= 0    = Nothing
  | otherwise = Just (steps n 0)
  where
    steps 1 acc = acc
    steps x acc
      | even x    = steps (x `div` 2) (acc + 1)
      | otherwise = steps (3 * x + 1) (acc + 1)
