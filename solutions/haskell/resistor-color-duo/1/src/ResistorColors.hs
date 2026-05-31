module ResistorColors (Color(..), value) where

data Color =
    Black
  | Brown
  | Red
  | Orange
  | Yellow
  | Green
  | Blue
  | Violet
  | Grey
  | White
  deriving (Eq, Show, Enum, Bounded)

value :: (Color, Color) -> Int
value (a, b) = (cmap a) *10 + cmap b

cmap :: Color -> Int
cmap c 
  | c == Black = 0
  | c == Brown = 1
  | c == Red = 2
  | c == Orange = 3
  | c == Yellow = 4
  | c == Green = 5
  | c == Blue = 6
  | c == Violet = 7
  | c == Grey = 8
  | c == White = 9
