module Views.PlaneSelector exposing (view)

import Data.Model exposing (Model)
import Data.Msg exposing (Msg(..))
import Data.Planes exposing (Plane, planes)
import Html exposing (Html)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)


option : Maybe Plane -> Plane -> Html Msg
option selectedPlane plane =
    Html.option
        [ value plane.registration
        , case selectedPlane of
            Just p ->
                if p == plane then
                    selected True

                else
                    selected False

            Nothing ->
                selected False
        ]
        [ Html.text <| plane.registration ++ " (" ++ plane.type_ ++ ")" ]


view : Model -> Html Msg
view model =
    Html.div []
        [ Html.label []
            [ Html.span [] [ Html.text "Avion " ]
            , List.map (option model.selectedPlane) planes
                |> Html.select [ onInput SelectPlane ]
            ]
        ]
