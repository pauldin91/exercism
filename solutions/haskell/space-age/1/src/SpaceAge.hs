module SpaceAge (Planet(..), ageOn) where

data Planet = Mercury
            | Venus
            | Earth
            | Mars
            | Jupiter
            | Saturn
            | Uranus
            | Neptune
            deriving(Eq)


secToYears :: Float -> Float
secToYears sec = ((sec/3600)/24)/365.25

ageOn :: Planet -> Float -> Float
ageOn planet seconds 
          | planet == Mercury = secToYears(seconds) / 0.2408467
          | planet == Venus = secToYears(seconds) / 0.61519726
          | planet == Earth = secToYears(seconds) 
          | planet == Mars = secToYears(seconds) / 1.8808158
          | planet == Jupiter = secToYears(seconds) /  11.862615
          | planet == Saturn = secToYears(seconds) / 29.447498
          | planet == Uranus = secToYears(seconds) / 84.016846
          | planet == Neptune = secToYears(seconds) / 164.79132
