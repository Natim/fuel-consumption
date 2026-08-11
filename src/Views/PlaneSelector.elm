module Views.PlaneSelector exposing (view)

import Html exposing (Html)
import Html.Attributes exposing (selected, value)
import Html.Events exposing (onInput)
import Msg exposing (Msg(..))
import Plane exposing (Plane)


option : Plane -> Plane -> Html Msg
option selectedPlane plane =
    Html.option
        [ value plane.registration
        , selected (plane.registration == selectedPlane.registration)
        ]
        [ Html.text (plane.registration ++ " (" ++ plane.type_ ++ ")") ]


view : { a | selectedPlane : Plane } -> Html Msg
view { selectedPlane } =
    Html.div []
        [ Html.label []
            [ Html.span [] [ Html.text "Avion " ]
            , Plane.all
                |> List.map (option selectedPlane)
                |> Html.select [ onInput SelectPlane ]
            ]
        ]
