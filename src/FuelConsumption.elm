module FuelConsumption exposing (main)

import Browser
import Html exposing (Html)
import Msg exposing (Msg(..))
import Plane exposing (Plane)
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


type alias Model =
    { initialFuel : Maybe Int
    , fuelFlow : Maybe Int
    , flightTime : Maybe Int
    , selectedPlane : Plane
    }


defaultFlightTime : Int
defaultFlightTime =
    45


init : () -> ( Model, Cmd Msg )
init _ =
    ( { initialFuel = Just Plane.default.tankCapacity
      , fuelFlow = Just Plane.default.fuelFlow
      , flightTime = Just defaultFlightTime
      , selectedPlane = Plane.default
      }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateFlightTime value ->
            ( { model | flightTime = String.toInt value }, Cmd.none )

        UpdateInitialFuel value ->
            ( { model
                | initialFuel =
                    String.toInt value
                        |> Maybe.map (Plane.clampToTank model.selectedPlane)
              }
            , Cmd.none
            )

        UpdateFuelFlow value ->
            ( { model | fuelFlow = String.toInt value }, Cmd.none )

        SelectPlane registration ->
            case Plane.fromRegistration registration of
                Just plane ->
                    ( { model
                        | fuelFlow = Just plane.fuelFlow
                        , initialFuel =
                            model.initialFuel
                                |> Maybe.withDefault plane.tankCapacity
                                |> Plane.clampToTank plane
                                |> Just
                        , selectedPlane = plane
                      }
                    , Cmd.none
                    )

                Nothing ->
                    ( model, Cmd.none )


view : Model -> Html Msg
view model =
    Html.div []
        [ PlaneSelector.view model
        , Form.view model
        , FuelInfo.view model
        ]
