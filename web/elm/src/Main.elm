port module Main exposing (..)

import Html exposing (..)
import Html.App as App
import Material
import Material.Layout as Layout
import Model exposing (Model)
import Update exposing (update)
import View exposing (view)
import Msg exposing (Msg(..), FormationMsg(..))
import API


main : Program Never
main =
    App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- model =
--     Model.initialModel
-- { model | mdl = Layout.setTabsWidth 120 model.mdl }


init : ( Model, Cmd Msg )
init =
    ( Model.initialModel, API.fetchFormations (always NoOp) (FormationMsg' << GotFormations) )


subscriptions : Model -> Sub Msg
subscriptions model =
    Material.subscriptions Mdl model
