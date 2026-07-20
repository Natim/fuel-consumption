module Data.Planes exposing (Plane, planes)


type alias Plane =
    { type_ : String
    , immat : String
    , owner : String
    , fuel_flow : Int
    , max_quantity : Int
    }


planes : List Plane
planes =
    [ Plane "DR400-Rotax" "F-GORZ" "RAC" 15 110
    , Plane "PA28" "F-GHYZ" "RAC" 40 189
    , Plane "WT9" "F-GOOS" "FGA" 17 126
    ]
