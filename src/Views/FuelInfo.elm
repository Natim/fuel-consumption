module Views.FuelInfo exposing (view)

import Html exposing (Html)
import Msg exposing (Msg)


view :
    { a
        | fuelFlow : Maybe Int
        , flightTime : Maybe Int
        , initialFuel : Maybe Int
    }
    -> Html Msg
view { fuelFlow, flightTime, initialFuel } =
    let
        usedFuel =
            Maybe.map2
                (\time flow -> toFloat time / 60 * toFloat flow)
                flightTime
                fuelFlow

        remainingFuel =
            Maybe.map2
                (\fuel used -> toFloat fuel - used)
                initialFuel
                usedFuel
    in
    Html.div []
        [ case usedFuel of
            Nothing ->
                Html.text ""

            Just used ->
                Html.h4 []
                    [ Html.text (String.fromInt (ceiling used))
                    , Html.text " litres consommés"
                    ]
        , case remainingFuel of
            Nothing ->
                Html.text ""

            Just remaining ->
                Html.h3 []
                    [ Html.span [] [ Html.text (String.fromInt (floor remaining)) ]
                    , Html.text " litres restants"
                    ]
        ]
