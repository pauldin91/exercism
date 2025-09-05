module SumOfMultiples (sumOfMultiples) where

import Data.List (nub)

sumOfMultiples :: [Integer] -> Integer -> Integer
sumOfMultiples factors limit = sum . nub . concat $ [build c limit | c <- factors]
  where
    build :: Integer -> Integer -> [Integer]
    build c limit  
             | c /=0 = filter (\x -> x `mod` c == 0) [1 .. limit - 1]
             | True = [0]