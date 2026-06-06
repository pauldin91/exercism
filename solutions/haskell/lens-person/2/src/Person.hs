
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





bornStreet :: Born -> String
bornStreet = _street . _bornAt
 
setCurrentStreet :: String -> Person -> Person
setCurrentStreet s person =
  person
    { _address =
        (_address person)
          { _street = s
          }
    }

setBirthMonth :: Int -> Person -> Person
setBirthMonth m person =
  person
    { _born =
        (_born person)
          { _bornOn =
              let d = _bornOn (_born person)
                  (y, _, dayOfMonth) = toGregorian d
              in fromGregorian y m dayOfMonth
          }
    }

renameStreets :: (String -> String) -> Person -> Person
renameStreets f person =
  person
    { _address =
        (_address person)
          { _street = f (_street (_address person)) }
    , _born =
        (_born person)
          { _bornAt =
              (_bornAt (_born person))
                { _street = f (_street (_bornAt (_born person))) }
          }
    }
