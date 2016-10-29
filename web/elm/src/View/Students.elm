module View.Students exposing (view, header)

import Html exposing (..)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Msg exposing (Msg(..), StudentMsg(..))
import Route exposing (Location(..))
import Types exposing (Student)
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
        [ case model.students of
            Nothing ->
                noStudentsView

            Just students ->
                if List.isEmpty students then
                    noStudentsView
                else
                    studentsView model students
        ]


noStudentsView : Html Msg
noStudentsView =
    div
        []
        [ text "<No students>" ]


studentsView : Model -> List Student -> Html Msg
studentsView model students =
    Table.table
        [ Options.css "margin" "5px 5px"
        ]
        [ Table.thead []
            [ Table.tr []
                [ Table.th [] [ text "First name" ]
                , Table.th [] [ text "Last name" ]
                , Table.th [] [ text "Id" ]
                , Table.th [] [ text "Actions" ]
                ]
            ]
        , Table.tbody []
            (students
                |> List.indexedMap
                    (\index student ->
                        Table.tr []
                            [ Table.td [] [ text student.firstName ]
                            , Table.td [] [ text student.lastName ]
                            , Table.td [] [ text <| toString <| Maybe.withDefault 0 student.id ]
                            , Table.td []
                                [ editButton model index student
                                , deleteButton model index student
                                ]
                            ]
                    )
            )
        ]


deleteButton : Model -> Int -> Student -> Html Msg
deleteButton model index student =
    Button.render Mdl
        [ 0, 1, index ]
        model.mdl
        [ Button.minifab
        , Button.colored
        , Button.ripple
        , Button.onClick <| StudentMsg' <| DeleteStudent student
        ]
        [ Icon.i "delete" ]


editButton : Model -> Int -> Student -> Html Msg
editButton model index student =
    case student.id of
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


addStudentButton : Model -> Html Msg
addStudentButton model =
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
        , Button.onClick <| NavigateTo <| Just NewStudent
        ]
        [ Icon.i "add" ]


header : Model -> List (Html Msg)
header model =
    Helpers.defaultHeaderWithNavigation model
        "Students"
        [ addStudentButton model
          --  switchViewButton model
          -- , addUserButton model
        ]
