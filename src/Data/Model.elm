module Data.Model exposing (Model, empty)

import Data.Planes exposing (Plane)


type alias Model =
    { initial_quantity : Maybe Int
    , fuel_flow : Maybe Int
    , flight_time : Maybe Int
    , selected_plane : Maybe Plane
    }


empty : Model
empty =
    { initial_quantity = Nothing
    , fuel_flow = Nothing
    , flight_time = Nothing
    , selected_plane = Nothing
    }
