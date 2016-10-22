port module Main exposing (..)

import Navigation
import Html exposing (..)
import Html.App as App
import Material
import Material.Layout as Layout
import Model exposing (Model)
import Update exposing (update)
import View exposing (view)
import Msg exposing (Msg(..), FormationMsg(..))
import API
import Route


type alias ProgramFlags =
    {}


main : Program ProgramFlags
main =
    Navigation.programWithFlags (Navigation.makeParser Route.locFor)
        { init = init
        , update = update
        , urlUpdate = urlUpdate
        , view = view
        , subscriptions = subscriptions
        }



-- model =
--     Model.initialModel
-- { model | mdl = Layout.setTabsWidth 120 model.mdl }


urlUpdate : Maybe Route.Location -> Model -> ( Model, Cmd Msg )
urlUpdate location oldModel =
    let
        newModel =
            { oldModel | route = Debug.log "location" location }
    in
        newModel ! [ API.fetchFormations (always NoOp) (FormationMsg' << GotFormations) ]



-- let
--     newUserForm =
--         (Model.initialModel Nothing).usersModel.newUserForm
--     oldUsersModel =
--         oldModel.usersModel
--     newUsersModel =
--         { oldUsersModel | newUserForm = newUserForm }
--     newModelWithClearedForms =
--         { oldModel | route = location, usersModel = newUsersModel }
--     ( newModel, loginRedirectCmd ) =
--         case newModelWithClearedForms.apiKey of
--             Nothing ->
--                 case newModelWithClearedForms.route of
--                     Just Login ->
--                         newModelWithClearedForms ! []
--                     _ ->
--                         { newModelWithClearedForms | route = Just Login } ! [ Navigation.modifyUrl (Route.urlFor Login) ]
--             Just apiKey ->
--                 newModelWithClearedForms ! []
-- in
--     ( newModel
--     , Cmd.batch <| loginRedirectCmd :: (Util.cmdsForModelRoute newModel)
--     )


init : ProgramFlags -> Maybe Route.Location -> ( Model, Cmd Msg )
init programFlags location =
    urlUpdate location <| Model.initialModel location


subscriptions : Model -> Sub Msg
subscriptions model =
    Material.subscriptions Mdl model
