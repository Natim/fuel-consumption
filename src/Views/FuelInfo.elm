module Views.FuelInfo exposing (view)

import Fuel
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
                (\time flow -> Fuel.used { flightTime = time, fuelFlow = flow })
                flightTime
                fuelFlow

        remainingFuel =
            Maybe.map3
                (\time flow fuel ->
                    Fuel.remaining { flightTime = time, fuelFlow = flow, initialFuel = fuel }
                )
                flightTime
                fuelFlow
                initialFuel
    in
    Html.div []
        [ usedFuel
            |> Maybe.map usedView
            |> Maybe.withDefault (Html.text "")
        , remainingFuel
            |> Maybe.map remainingView
            |> Maybe.withDefault (Html.text "")
        ]


usedView : Float -> Html Msg
usedView used =
    Html.h4 []
        [ Html.text (String.fromInt (ceiling used))
        , Html.text " litres consommés"
        ]


remainingView : Float -> Html Msg
remainingView remaining =
    if remaining < 0 then
        Html.h3 []
            [ Html.span [] [ Html.text "Autonomie insuffisante" ]
            , Html.text (" — il manque " ++ String.fromInt (ceiling (abs remaining)) ++ " litres")
            ]

    else
        Html.h3 []
            [ Html.span [] [ Html.text (String.fromInt (floor remaining)) ]
            , Html.text " litres restants"
            ]
