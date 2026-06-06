{-# LANGUAGE TemplateHaskell #-}
module Person
  ( Address (..)
  , Born    (..)
  , Name    (..)
  , Person  (..)
  , bornStreet
  , renameStreets
  , setBirthMonth
  , setCurrentStreet
  ) where

import Data.Time.Calendar (Day,fromGregorian,toGregorian)
import Control.Lens
import Control.Lens.TH

data Name = Name { _foreNames :: String
                 , _surName   :: String
                 }
data Address = Address { _street      :: String
                       , _houseNumber :: Int
                       , _place       :: String
                       , _country     :: String
                       }
data Born = Born { _bornAt :: Address
                 , _bornOn :: Day
                 }
data Person = Person { _name    :: Name
                     , _born    :: Born
                     , _address :: Address
                     }

$(makeLenses ''Name)
$(makeLenses ''Address)                       
$(makeLenses ''Born)
$(makeLenses ''Person)




bornStreet :: Born -> String
bornStreet  born =  born ^. bornAt . street
 
setCurrentStreet :: String -> Person -> Person
setCurrentStreet s person = set (address . street) s person

setBirthMonth :: Int -> Person -> Person
setBirthMonth m =
    over (born . bornOn) $ \d ->
        let (y, _, dayOfMonth) = toGregorian d
        in fromGregorian y m dayOfMonth

renameStreets :: (String -> String) -> Person -> Person
renameStreets f =
    over (address . street) f .
    over (born . bornAt . street) f
