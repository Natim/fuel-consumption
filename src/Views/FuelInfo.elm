module Views.FuelInfo exposing (view)

import Data.Model exposing (Model)
import Data.Msg exposing (Msg(..))
import Html exposing (Html)
import Html.Attributes exposing (..)


view : Model -> Html Msg
view model =
    let
        usedFuel =
            Maybe.map2
                (\flightTime fuelFlow -> toFloat flightTime / 60 * toFloat fuelFlow)
                model.flightTime
                model.fuelFlow

        remainingFuel =
            Maybe.map2
                (\initialFuel used -> toFloat initialFuel - used)
                model.initialFuel
                usedFuel
    in
    Html.div []
        [ case usedFuel of
            Nothing ->
                Html.text ""

            Just used ->
                Html.h4 []
                    [ Html.text <| String.fromInt <| ceiling used
                    , Html.text " litres consommés"
                    ]
        , case remainingFuel of
            Nothing ->
                Html.text ""

            Just remaining ->
                Html.h3 []
                    [ Html.span [] [ Html.text <| String.fromInt <| floor remaining ]
                    , Html.text " litres restants"
                    ]
        ]
