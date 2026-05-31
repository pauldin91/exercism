module LinkedList
    ( LinkedList
    , datum
    , fromList
    , isNil
    , new
    , next
    , nil
    , reverseLinkedList
    , toList
    ) where

data LinkedList a = Empty | Next a (LinkedList a) deriving (Eq, Show)

datum :: LinkedList a -> a
datum (Next x _) = x

fromList :: [a] -> LinkedList a
fromList [] = Empty
fromList [x] = Next x Empty
fromList (x:xs) = Next x (fromList xs)

isNil :: LinkedList a -> Bool
isNil Empty = True
isNil _ = False

new :: a -> LinkedList a -> LinkedList a
new x Empty = Next x Empty
new x list = Next x list

next :: LinkedList a -> LinkedList a
next Empty = Empty
next (Next _ rest) =  rest

nil :: LinkedList a
nil = Empty

reverseLinkedList :: LinkedList a -> LinkedList a
reverseLinkedList Empty = Empty 
reverseLinkedList linked = fromList (reverse (toList linked ))

toList :: LinkedList a -> [a]
toList Empty = []
toList (Next x rest) = x:toList rest
