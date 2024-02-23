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
import Views.PlaneSelector as PlaneSelector


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
            ( { initial_quantity = Just f.max_quantity
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

        UpdatePlaneSelection immat ->
            let
                plane =
                    planes
                        |> List.filter (\p -> p.immat == immat)
                        |> List.head
            in
            case plane of
                Just p ->
                    ( { model
                        | fuel_flow = Just p.fuel_flow
                        , initial_quantity = Basics.min (model.initial_quantity |> Maybe.withDefault p.max_quantity) p.max_quantity |> Just
                        , selected_plane = Just p
                      }
                    , Cmd.none
                    )

                Nothing ->
                    ( { model
                        | fuel_flow = Nothing
                        , selected_plane = Nothing
                      }
                    , Cmd.none
                    )


view : Model -> Html Msg
view model =
    Html.div []
        [ PlaneSelector.view model
        , Form.view model
        , FuelInfo.view model
        ]
