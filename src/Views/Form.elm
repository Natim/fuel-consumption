module Views.Form exposing (view)

import Data.Model exposing (Model)
import Data.Msg exposing (Msg(..))
import Html exposing (Html)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)


view : Model -> Html Msg
view model =
    Html.div []
        [ Html.div []
            [ Html.label []
                [ Html.span [] [ Html.text "Consommation horaire " ]
                , Html.input
                    [ type_ "number"
                    , value <| String.fromInt <| Maybe.withDefault 0 model.fuel_flow
                    , onInput UpdateFuelFlow
                    ]
                    []
                ]
            ]
        , Html.div []
            [ Html.label []
                [ Html.span [] [ Html.text "Temps de vol (minutes) " ]
                , Html.input
                    [ type_ "number"
                    , value <| String.fromInt <| Maybe.withDefault 0 model.flight_time
                    , onInput UpdateFlightTime
                    ]
                    []
                ]
            ]
        , Html.div []
            [ Html.label []
                [ Html.span [] [ Html.text "Carburant de départ" ]
                , Html.input
                    [ type_ "number"
                    , value <| String.fromInt <| Maybe.withDefault 0 model.initial_quantity
                    , onInput UpdateInitialQuantity
                    ]
                    []
                ]
            ]
        ]
