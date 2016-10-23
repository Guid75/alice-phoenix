module View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (id)
import Material
import Material.Scheme
import Material.Button as Button
import Material.Tabs as Tabs
import Material.Icon as Icon
import Material.Layout as Layout
import Material.Options as Options exposing (css)
import Material.Color as Color
import Model exposing (Model)
import Msg exposing (Msg(..))
import View.Formations
import View.Formations.New
import Route exposing (Location(..))


studentsTab : Model -> Html Msg
studentsTab model =
    text "students"


getContent : Model -> Html Msg
getContent model =
    case model.route of
        Just Formations ->
            View.Formations.view model

        Just NewFormation ->
            View.Formations.New.view model

        Just Users ->
            studentsTab model

        Just NewUser ->
            studentsTab model

        _ ->
            div [] []


routeToTab : Model -> Int
routeToTab model =
    case model.route of
        Just Formations ->
            0

        Just NewFormation ->
            0

        Just Users ->
            1

        Just NewUser ->
            1

        _ ->
            2


view : Model -> Html Msg
view model =
    Layout.render Mdl
        model.mdl
        [ Layout.selectedTab <| routeToTab model
        , Layout.onSelectTab SelectTab
        , Layout.fixedHeader
        ]
        { header = [ Layout.row [] [ Layout.title [] [ text "ALICE" ] ] ]
        , drawer = []
        , tabs =
            ( [ div [ id "formations" ] [ text "formations" ]
              , div [ id "students" ] [ text "Students" ]
              , div [ id "another" ] [ text "Another thing" ]
              ]
            , [ Color.background (Color.color Color.Teal Color.S400) ]
            )
        , main = [ getContent model ]
        }
        |> Material.Scheme.topWithScheme Color.Teal Color.Red



--WithScheme Color.Teal Color.Red
-- view : Model -> Html Msg
-- view model =
--     (div
--      []
--      <|
--         List.concat
--             [ [ Tabs.render Mdl
--                     [ 0 ]
--                     model.mdl
--                     [ Tabs.ripple
--                     , Tabs.onSelectTab SelectTab
--                     , Tabs.activeTab model.tab
--                     ]
--                     [ Tabs.label
--                         [ Options.center ]
--                         [ Icon.i "info_outline"
--                         , Options.span [ css "width" "4px" ] []
--                         , text "Formations"
--                         ]
--                     , Tabs.label
--                         [ Options.center ]
--                         [ Icon.i "code"
--                         , Options.span [ css "width" "4px" ] []
--                         , text "Students"
--                         ]
--                     ]
--                     [ case model.tab of
--                         0 ->
--                             --App.map FormationsMsg <| Formation.View.root model.formations
--                             View.Formations.view model
--                         _ ->
--                             studentsTab model
--                     ]
--               ]
--             ]
--     )
--         |> Material.Scheme.top
