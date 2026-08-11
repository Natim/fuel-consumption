module Data.Msg exposing (Msg(..))


type Msg
    = UpdateFlightTime String
    | UpdateInitialFuel String
    | UpdateFuelFlow String
    | SelectPlane String
