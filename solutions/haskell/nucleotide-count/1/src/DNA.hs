module DNA (nucleotideCounts, Nucleotide(..)) where

import qualified Data.Map as Map
import Data.Maybe (fromMaybe)

data Nucleotide = A | C | G | T deriving (Eq, Ord, Show)

nucleotideCounts :: String -> Either String (Map.Map Nucleotide Int)
nucleotideCounts xs 
    | onlyDNA xs = Right (countNucleotides xs)
    | otherwise  = Left "invalid DNA sequence"
  where
    onlyDNA = all (`elem` "ACGT")

    countNucleotides :: String -> Map.Map Nucleotide Int
    countNucleotides = foldr update initialMap

    update :: Char -> Map.Map Nucleotide Int -> Map.Map Nucleotide Int
    update 'A' = Map.adjust (+1) A
    update 'C' = Map.adjust (+1) C
    update 'G' = Map.adjust (+1) G
    update 'T' = Map.adjust (+1) T
    update  _  = id  -- shouldn't happen due to onlyDNA check

    initialMap :: Map.Map Nucleotide Int
    initialMap = Map.fromList [(A, 0), (C, 0), (G, 0), (T, 0)]
