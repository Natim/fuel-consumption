module FuelConsumption exposing (main)

import Browser
import Data.Model as Model exposing (Model)
import Data.Msg exposing (Msg(..))
import Data.Planes exposing (planes)
import Html exposing (Html)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import Views.Form as Form
import Views.FuelInfo as FuelInfo


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
    case planes of
        f :: fx ->
            ( { initial_quantity = Just 130
              , fuel_flow = Just f.fuel_flow
              , flight_time = Just 45
              , selected_plane = Just f
              }
            , Cmd.none
            )

        [] ->
            ( Model.empty, Cmd.none )


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
    Html.div []
        [ Form.view model
        , FuelInfo.view model
        ]
