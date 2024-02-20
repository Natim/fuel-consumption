module Data.Model exposing (Model)


type alias Model =
    { initial_quantity : Maybe Int
    , fuel_flow : Maybe Int
    , flight_time : Maybe Int
    }
