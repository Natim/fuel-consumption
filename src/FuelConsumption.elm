module FuelConsumption exposing (main)

import Browser
import Data.Model as Model exposing (Model)
import Data.Msg exposing (Msg(..))
import Data.Planes exposing (planes)
import Html exposing (Html)
import Html.Attributes exposing (..)
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
        firstPlane :: _ ->
            ( { initialFuel = Just firstPlane.tankCapacity
              , fuelFlow = Just firstPlane.fuelFlow
              , flightTime = Just 45
              , selectedPlane = Just firstPlane
              }
            , Cmd.none
            )

        [] ->
            ( Model.empty, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateFlightTime value ->
            ( { model | flightTime = String.toInt value }, Cmd.none )

        UpdateInitialFuel value ->
            ( { model | initialFuel = String.toInt value }, Cmd.none )

        UpdateFuelFlow value ->
            ( { model | fuelFlow = String.toInt value }, Cmd.none )

        SelectPlane registration ->
            let
                plane =
                    planes
                        |> List.filter (\p -> p.registration == registration)
                        |> List.head
            in
            case plane of
                Just p ->
                    ( { model
                        | fuelFlow = Just p.fuelFlow
                        , initialFuel = Basics.min (model.initialFuel |> Maybe.withDefault p.tankCapacity) p.tankCapacity |> Just
                        , selectedPlane = Just p
                      }
                    , Cmd.none
                    )

                Nothing ->
                    ( { model
                        | fuelFlow = Nothing
                        , selectedPlane = Nothing
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
