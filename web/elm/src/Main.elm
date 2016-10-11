port module Main exposing (..)

import Html exposing (..)
import Html.App as App
import Material
import Model exposing (Model)
import Update exposing (update)
import View exposing (view)
import Msg exposing (Msg(..))


main : Program Never
main =
    App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


init : ( Model, Cmd Msg )
init =
    ( Model.initialModel, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Material.subscriptions Mdl model
