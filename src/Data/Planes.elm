module Data.Planes exposing (Plane, planes)


type alias Plane =
    { type_ : String
    , registration : String
    , owner : String
    , fuelFlow : Int
    , tankCapacity : Int
    }


planes : List Plane
planes =
    [ Plane "DR400-Rotax" "F-GORZ" "RAC" 15 110
    , Plane "PA28" "F-GHYZ" "RAC" 40 189
    , Plane "WT9" "F-GOOS" "FGA" 17 126
    ]
