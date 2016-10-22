module View.Formations exposing (view)

import Html exposing (..)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Msg exposing (Msg(..), FormationMsg(..))
import Route exposing (Location(..))
import Types exposing (Formation)
import Model exposing (Model)
import Material.Table as Table
import Material.Button as Button
import Material.Icon as Icon
import Material.Options as Options


view : Model -> Html Msg
view model =
    div
        []
        [ Button.render Mdl
            [ 0 ]
            model.mdl
            [ Button.raised
            , Button.ripple
            , Button.onClick <| NavigateTo <| Just NewFormation
            , Options.css "margin" "5px 5px"
            ]
            [ text "New formation" ]
        , case model.formations of
            Nothing ->
                noFormationsView

            Just formations ->
                formationsView formations
        ]


noFormationsView : Html Msg
noFormationsView =
    div
        []
        [ text "<No formations>" ]


formationsView : List Formation -> Html Msg
formationsView formations =
    Table.table
        [ Options.css "margin" "5px 5px"
        ]
        [ Table.thead []
            [ Table.tr []
                [ Table.th [] [ text "Title" ]
                , Table.th [] [ text "Id" ]
                ]
            ]
        , Table.tbody []
            (formations
                |> List.map
                    (\formation ->
                        Table.tr []
                            [ Table.td [] [ text formation.title ]
                            , Table.td [] [ text <| toString <| Maybe.withDefault 0 formation.id ]
                            ]
                    )
            )
        ]
