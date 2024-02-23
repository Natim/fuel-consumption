module Views.PlaneSelector exposing (view)

import Data.Model exposing (Model)
import Data.Msg exposing (Msg(..))
import Data.Planes exposing (Plane, planes)
import Html exposing (Html)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)


option : Plane -> Html Msg
option plane =
    Html.option [ value plane.immat ] [ Html.text <| plane.immat ++ " (" ++ plane.type_ ++ ")" ]


view : Model -> Html Msg
view model =
    Html.div []
        [ Html.label []
            [ Html.span [] [ Html.text "Avion " ]
            , List.map option planes
                |> Html.select [ onInput UpdatePlaneSelection ]
            ]
        ]
