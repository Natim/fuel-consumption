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
    [ Plane "PA28" "F-GEQX" "RAC" 33 189
    , Plane "PA28" "F-GHYZ" "RAC" 40 189
    , Plane "ELIXIR" "F-HTSA" "FGA" 13 120
    , Plane "WT9" "F-GOOS" "FGA" 17 120
    ]
