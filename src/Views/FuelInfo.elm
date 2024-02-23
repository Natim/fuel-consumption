module Views.FuelInfo exposing (view)

import Data.Model exposing (Model)
import Data.Msg exposing (Msg(..))
import Html exposing (Html)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)


view : Model -> Html Msg
view model =
    let
        used_fuel =
            Maybe.map2
                (\flight_time fuel_flow -> toFloat flight_time / 60 * toFloat fuel_flow)
                model.flight_time
                model.fuel_flow

        remaining_fuel =
            Maybe.map2
                (\initial_quantity usedFuel -> toFloat initial_quantity - usedFuel)
                model.initial_quantity
                used_fuel
    in
    Html.div []
        [ case used_fuel of
            Nothing ->
                Html.text ""

            Just usedFuel ->
                Html.h3 []
                    [ Html.text <| String.fromInt <| ceiling usedFuel
                    , Html.text " litres consommés"
                    ]
        , case remaining_fuel of
            Nothing ->
                Html.text ""

            Just remainingFuel ->
                Html.h3 []
                    [ Html.text <| String.fromInt <| floor remainingFuel
                    , Html.text " litres restants"
                    ]
        ]
