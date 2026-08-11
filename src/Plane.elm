module Plane exposing (Plane, all, default, fromRegistration)

{-| The club fleet.

`fuelFlow` is in litres per hour and `tankCapacity` in litres.

-}


type alias Plane =
    { type_ : String
    , registration : String
    , owner : String
    , fuelFlow : Int
    , tankCapacity : Int
    }


{-| The fleet is never empty, so callers can start from a `Plane` rather than
having to carry a `Maybe Plane` around for a case that cannot happen.
-}
default : Plane
default =
    Plane "DR400-Rotax" "F-GORZ" "RAC" 15 110


all : List Plane
all =
    [ default
    , Plane "PA28" "F-GHYZ" "RAC" 40 189
    , Plane "WT9" "F-GOOS" "FGA" 17 126
    ]


fromRegistration : String -> Maybe Plane
fromRegistration registration =
    all
        |> List.filter (\plane -> plane.registration == registration)
        |> List.head
