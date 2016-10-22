module Update exposing (update)

import Material
import Navigation
import Model exposing (Model)
import Msg exposing (Msg(..), UserMsg(..), FormationMsg(..))
import API
import Route exposing (Location(..))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case (Debug.log "msg" msg) of
        Mdl msg' ->
            Material.update msg' model

        UserMsg' msg ->
            updateUserMsg msg model

        FormationMsg' msg ->
            updateFormationMsg msg model

        SelectTab tab ->
            case tab of
                0 -> model ! [ Navigation.newUrl (Route.urlFor Formations) ]
                1 -> model ! [ Navigation.newUrl (Route.urlFor Users) ]
                _ -> model ! [ Navigation.newUrl (Route.urlFor Home) ]

        NavigateTo maybeLocation ->
            case maybeLocation of
                Nothing ->
                    model ! []

                Just location ->
                    model ! [ Navigation.newUrl (Route.urlFor location) ]

        NoOp ->
            model ! []


updateUserMsg : UserMsg -> Model -> ( Model, Cmd Msg )
updateUserMsg msg model =
    case Debug.log "updateUserMsg" msg of
        FetchUsers ->
            model ! [ API.fetchUsers (always NoOp) (UserMsg' << GotUsers) ]

        GotUsers users ->
            { model | users = Just users } ! []


updateFormationMsg : FormationMsg -> Model -> ( Model, Cmd Msg )
updateFormationMsg msg model =
    case Debug.log "updateFormationMsg" msg of
        FetchFormations ->
            model ! [ API.fetchFormations (always NoOp) (FormationMsg' << GotFormations) ]

        GotFormations formations ->
            { model | formations = Just formations } ! []
