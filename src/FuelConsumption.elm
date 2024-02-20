module FuelConsumption exposing (main)

import Browser
import Data.Model exposing (Model)
import Data.Msg exposing (Msg(..))
import Html exposing (Html)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , view = view
        , subscriptions = always Sub.none
        }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { initial_quantity = Just 130
      , fuel_flow = Just 40
      , flight_time = Just 45
      }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateFlightTime value ->
            ( { model | flight_time = String.toInt value }, Cmd.none )

        UpdateInitialQuantity value ->
            ( { model | initial_quantity = String.toInt value }, Cmd.none )

        UpdateFuelFlow value ->
            ( { model | fuel_flow = String.toInt value }, Cmd.none )


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
        , case used_fuel of
            Nothing ->
                Html.text ""

            Just usedFuel ->
                Html.h3 []
                    [ Html.text <| String.fromInt <| round usedFuel
                    , Html.text " litres consommés"
                    ]
        , case remaining_fuel of
            Nothing ->
                Html.text ""

            Just remainingFuel ->
                Html.h3 []
                    [ Html.text <| String.fromInt <| round remainingFuel
                    , Html.text " litres restants"
                    ]
        ]
