module Views.Form exposing (view)

import Html exposing (Html)
import Html.Attributes exposing (type_, value)
import Html.Events exposing (onInput)
import Msg exposing (Msg(..))


numberField : String -> Maybe Int -> (String -> Msg) -> Html Msg
numberField label current toMsg =
    Html.div []
        [ Html.label []
            [ Html.span [] [ Html.text label ]
            , Html.input
                [ type_ "number"
                , value (current |> Maybe.map String.fromInt |> Maybe.withDefault "")
                , onInput toMsg
                ]
                []
            ]
        ]


view :
    { a
        | fuelFlow : Maybe Int
        , flightTime : Maybe Int
        , initialFuel : Maybe Int
    }
    -> Html Msg
view { fuelFlow, flightTime, initialFuel } =
    Html.div []
        [ numberField "Consommation horaire " fuelFlow UpdateFuelFlow
        , numberField "Temps de vol (minutes) " flightTime UpdateFlightTime
        , numberField "Carburant de départ" initialFuel UpdateInitialFuel
        ]
