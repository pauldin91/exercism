module DNA (toRNA) where

toRNA :: String -> Either Char String
toRNA xs = traverse conv xs
  where 
    conv c 
       | c=='G' = Right 'C'
       | c=='C' = Right 'G'
       | c=='T' = Right 'A'
       | c=='A' = Right 'U'
       | True   = Left c
    
