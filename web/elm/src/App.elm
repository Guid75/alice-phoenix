port module App exposing (..)

import Html exposing (..)
import Html.App as App
import Html.Events exposing (..)
import Http
import Task
import Json.Decode as Json


main : Program Never
main =
    App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias Model =
    { id : String
    }


type Msg
    = NoOp
    | UsersPlease
    | UsersFetchSucceed String
    | UsersFetchFail Http.Error


init : ( Model, Cmd Msg )
init =
    initModel ! []


initModel : Model
initModel =
    { id = ""
    }


view : Model -> Html Msg
view model =
    div
        []
        [ text <| "Id:" ++ model.id
        , button
            [ onClick UsersPlease ]
            [ text "Click me" ]
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []

        UsersPlease ->
            model ! [ getUsers ]

        UsersFetchSucceed id ->
            { model | id = id } ! []

        UsersFetchFail _ ->
            model ! []


getUsers : Cmd Msg
getUsers =
    Task.perform UsersFetchFail UsersFetchSucceed (Http.get decodeUsers "/users")


decodeUsers : Json.Decoder String
decodeUsers =
    Json.at [ "id" ] Json.string


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
