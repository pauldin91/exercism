module PerfectNumbers (classify, Classification(..)) where

data Classification = Deficient | Perfect | Abundant deriving (Eq, Show)

aliquot n = sum [ x | x <-[1..n-1], mod n x == 0 ]

classify :: Int -> Maybe Classification
classify n 
    | n <= 0         = Nothing
    | aliquot n == n = Just Perfect
    | aliquot n < n  = Just Deficient
    | otherwise      = Just Abundant

