module View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (id, style)
import Material
import Material.Scheme
import Material.Button as Button
import Material.Tabs as Tabs
import Material.Icon as Icon
import Material.Layout as Layout
import Material.Options as Options exposing (css, when)
import Material.Color as Color
import Material.Card as Card
import Material.Elevation as Elevation
import Model exposing (Model)
import Msg exposing (Msg(..))
import View.Formations
import View.Formations.New
import View.Students
import View.Students.New
import View.Helpers as Helpers
import Route exposing (Location(..))


testing : Model -> Html Msg
testing model =
    Options.div
        [ css "margins" "12" ]
        [ Card.view
            [ Elevation.e4
            , Color.background Color.white
            ]
            [ Card.title
                []
                [ Card.head [] [ text "Première Agri" ]
                , Card.subhead [] [ text "23 élèves" ]
                ]
            , Card.text
                []
                [ div [] [ text "Guillaume Denry" ]
                , div [] [ text "Vincent Denry" ]
                ]
            ]
        ]


getContent : Model -> Html Msg
getContent model =
    case model.route of
        Just Formations ->
            View.Formations.view model

        Just NewFormation ->
            View.Formations.New.view model

        Just Students ->
            View.Students.view model

        Just NewStudent ->
            View.Students.New.view model

        _ ->
            testing model



--            div [] []


routeToTab : Model -> Int
routeToTab model =
    case model.route of
        Just Formations ->
            0

        Just NewFormation ->
            0

        Just Students ->
            1

        Just NewStudent ->
            1

        _ ->
            2


type alias MenuItem =
    { text : String
    , iconName : String
    , route : Maybe Route.Location
    }


menuItems : List MenuItem
menuItems =
    [ { text = "Formations", iconName = "group", route = Just Formations }
    , { text = "Students", iconName = "group", route = Just Students }
    , { text = "Workshops", iconName = "alarm", route = Just Workshops }
    ]


drawer : Model -> List (Html Msg)
drawer model =
    [ Layout.title []
        [ text "ALICE" ]
    , Layout.navigation
        [ Options.css "flex-grow" "1" ]
        (List.map (drawerMenuItem model) menuItems)
    ]


drawerMenuItem : Model -> MenuItem -> Html Msg
drawerMenuItem model menuItem =
    Layout.link
        [ Layout.onClick (NavigateTo menuItem.route)
        , (Color.text <| Color.accent) `when` (model.route == menuItem.route)
        , Options.css "font-weight" "500"
        , Options.css "cursor" "pointer"
          -- http://outlinenone.com/ TODO: tl;dr don't do this
          -- Should be using ":focus { outline: 0 }" for this but can't do that with inline styles so this is a hack til I get a proper stylesheet on here.
        , Options.css "outline" "none"
        ]
        [ Icon.view menuItem.iconName
            [ Options.css "margin-right" "32px"
            ]
        , text menuItem.text
        ]


header : Model -> List (Html Msg)
header model =
    case model.route of
        Just Formations ->
            View.Formations.header model

        Just NewFormation ->
            View.Formations.header model

        Just Students ->
            View.Students.header model

        Just NewStudent ->
            View.Students.header model

        Nothing ->
            Helpers.defaultHeader model "ALICE"

        _ ->
            View.Formations.header model


view : Model -> Html Msg
view model =
    Layout.render Mdl
        model.mdl
        [ Layout.selectedTab <| routeToTab model
        , Layout.onSelectTab SelectTab
        , Layout.fixedHeader
        , Layout.fixedDrawer
        ]
        { header = header model
        , drawer = drawer model
        , tabs = ( [], [] )
        , main = [ getContent model ]
        }
        |> Material.Scheme.topWithScheme Color.Teal Color.Red
