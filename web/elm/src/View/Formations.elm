module View.Formations exposing (view)

import Html exposing (..)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Msg exposing (Msg(..))
import Types exposing (Formation)
import Model exposing (Model)


view : Model -> Html Msg
view model =
    case model.formations of
        Nothing ->
            noFormationsView

        Just formations ->
            formationsView formations


noFormationsView : Html Msg
noFormationsView =
    div
        []
        [ text "<No formations>" ]


formationsView : List Formation -> Html Msg
formationsView formations =
    div
        []
        (List.map
            (\formation ->
                div
                    [ style
                        [ ( "color", "red" )
                        ]
                    ]
                    [ text formation.title ]
            )
            formations
        )
