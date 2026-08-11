module Msg exposing (Msg(..))

{-| Kept apart from the model so the view modules can build messages without
importing the main module, which imports them in turn.
-}


type Msg
    = UpdateFlightTime String
    | UpdateInitialFuel String
    | UpdateFuelFlow String
    | SelectPlane String
