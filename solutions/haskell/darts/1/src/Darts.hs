module Darts (score) where


score :: Float -> Float -> Int
root x y = sqrt x*x + y*y
score x y  
           | r <= 1 = 10
           | r <= 5 = 5
           | r <= 10 = 1
           | otherwise  = 0
           where r = sqrt (x*x + y*y)
