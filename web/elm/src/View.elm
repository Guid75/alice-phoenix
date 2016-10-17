module View exposing (view)

import Html exposing (..)
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


studentsTab : Model -> Html Msg
studentsTab model =
    text "students"


formationsTab : Model -> Html Msg
formationsTab model =
    text "formations"


view : Model -> Html Msg
view model =
    Layout.render Mdl
        model.mdl
        [ Layout.selectedTab model.tab
        , Layout.onSelectTab SelectTab
        , Layout.fixedHeader
        ]
        { header = [ Layout.row [] [ Layout.title [] [ text "ALICE" ] ] ]
        , drawer = []
        , tabs =
            ( [ text "formations"
              , text "Students"
              , text "Another thing"
              ]
            , [ Color.background (Color.color Color.Teal Color.S400) ]
            )
        , main = [ text "content" ]
        }
        |> Material.Scheme.top



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
