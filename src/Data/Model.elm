module Data.Model exposing (Model, empty)

import Data.Planes exposing (Plane)


type alias Model =
    { initialFuel : Maybe Int
    , fuelFlow : Maybe Int
    , flightTime : Maybe Int
    , selectedPlane : Maybe Plane
    }


empty : Model
empty =
    { initialFuel = Nothing
    , fuelFlow = Nothing
    , flightTime = Nothing
    , selectedPlane = Nothing
    }
