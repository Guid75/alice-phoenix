port module App exposing (..)

import Html exposing (..)
import Html.App as App
import Html.Events exposing (..)
import Http
import Task
import Json.Decode as Json
import Material
import Material.Scheme
import Material.Button as Button
import Material.Tabs as Tabs
import Material.Icon as Icon
import Material.Options as Options exposing (css)
import Model
import Update

main : Program Never
main =
    App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


studentsTab : Model -> Html Msg
studentsTab model =
    text "ok"


view : Model -> Html Msg
view model =
    (div
        []
     <|
        List.concat
            [ [ Tabs.render Mdl
                    [ 0 ]
                    model.mdl
                    [ Tabs.ripple
                    , Tabs.onSelectTab SelectTab
                    , Tabs.activeTab model.tab
                    ]
                    [ Tabs.label
                        [ Options.center ]
                        [ Icon.i "info_outline"
                        , Options.span [ css "width" "4px" ] []
                        , text "Formations"
                        ]
                    , Tabs.label
                        [ Options.center ]
                        [ Icon.i "code"
                        , Options.span [ css "width" "4px" ] []
                        , text "Students"
                        ]
                    ]
                    [ case model.tab of
                        0 ->
                            App.map FormationsMsg <| Formation.View.root model.formations

                        _ ->
                            studentsTab model
                    ]
              ]
            ]
    )
        |> Material.Scheme.top

handleFormationsUpdate : Model -> Formation.Types.Msg -> (Model, Cmd Msg)
handleFormationsUpdate model msg =
    let
        (newFormationsModel, formationsMsg) =
            Formation.State.update msg model.formations
        newModel =
            { model | formations = newFormationsModel }
    in
        (newModel, Cmd.none)

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []

        FormationsPlease ->
            model ! [ getFormations ]

        FormationsFetchSucceed formations ->
            handleFormationsUpdate model (Formation.Types.SetFormations formations)

        FormationsFetchFail _ ->
            model ! []

        SelectTab tab ->
            { model | tab = tab } ! []

        Mdl msg' ->
            Material.update msg' model

        FormationsMsg msg ->
            handleFormationsUpdate model msg


getFormations : Cmd Msg
getFormations =
    Task.perform FormationsFetchFail FormationsFetchSucceed (Http.get decodeFormations "/api/formations")


decodeFormation : Json.Decoder String
decodeFormation =
    Json.at [ "title" ] Json.string


decodeFormations : Json.Decoder (List String)
decodeFormations =
    Json.at [ "data" ] <| Json.list decodeFormation


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
