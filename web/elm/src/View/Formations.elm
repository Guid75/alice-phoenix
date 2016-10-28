module View.Formations exposing (view, header)

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
import View.Helpers as Helpers


view : Model -> Html Msg
view model =
    div
        []
        [ case model.formations of
            Nothing ->
                noFormationsView

            Just formations ->
                if List.isEmpty formations then
                    noFormationsView
                else
                    formationsView model formations
        ]


noFormationsView : Html Msg
noFormationsView =
    div
        []
        [ text "<No formations>" ]


formationsView : Model -> List Formation -> Html Msg
formationsView model formations =
    Table.table
        [ Options.css "margin" "5px 5px"
        ]
        [ Table.thead []
            [ Table.tr []
                [ Table.th [] [ text "Title" ]
                , Table.th [] [ text "Id" ]
                , Table.th [] [ text "Actions" ]
                ]
            ]
        , Table.tbody []
            (formations
                |> List.indexedMap
                    (\index formation ->
                        Table.tr []
                            [ Table.td [] [ text formation.title ]
                            , Table.td [] [ text <| toString <| Maybe.withDefault 0 formation.id ]
                            , Table.td []
                                [ editButton model index formation
                                , deleteButton model index formation
                                ]
                            ]
                    )
            )
        ]


deleteButton : Model -> Int -> Formation -> Html Msg
deleteButton model index formation =
    Button.render Mdl
        [ 0, 1, index ]
        model.mdl
        [ Button.minifab
        , Button.colored
        , Button.ripple
        , Button.onClick <| FormationMsg' <| DeleteFormation formation
        ]
        [ Icon.i "delete" ]


editButton : Model -> Int -> Formation -> Html Msg
editButton model index user =
    case user.id of
        Nothing ->
            text ""

        Just id ->
            Button.render Mdl
                [ 0, 2, index ]
                model.mdl
                [ Button.minifab
                , Button.colored
                , Button.ripple
                  --                , Button.onClick <| NavigateTo <| Just <| EditFormation id
                ]
                [ Icon.i "edit" ]


addFormationButton : Model -> Html Msg
addFormationButton model =
    Button.render Mdl
        [ 0, 0 ]
        model.mdl
        [ Options.css "position" "fixed"
        , Options.css "display" "block"
        , Options.css "right" "0"
        , Options.css "top" "0"
        , Options.css "margin-right" "35px"
        , Options.css "margin-top" "35px"
        , Options.css "z-index" "900"
        , Button.fab
        , Button.colored
        , Button.ripple
        , Button.onClick <| NavigateTo <| Just NewFormation
        ]
        [ Icon.i "add" ]


header : Model -> List (Html Msg)
header model =
    Helpers.defaultHeaderWithNavigation model
        "Formations"
        [ addFormationButton model
          --  switchViewButton model
          -- , addUserButton model
        ]
