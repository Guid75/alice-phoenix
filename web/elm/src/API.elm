module API
    exposing
        ( fetchUsers
        , fetchFormations
        , createFormation
        , deleteFormation
        )

import Json.Encode as JE
import Json.Decode as JD
import Http
import Task
import Msg exposing (Msg(..), UserMsg(..), FormationMsg(..))
import Decoders exposing (usersDecoder, formationsDecoder, formationDecoder)
import Json.Decode exposing ((:=))
import Types exposing (User, Formation)
import OurHttp


fetchUsers : (Http.Error -> Msg) -> (List User -> Msg) -> Cmd Msg
fetchUsers errorMsg msg =
    get "/api/users" usersDecoder errorMsg msg


fetchFormations : (Http.Error -> Msg) -> (List Formation -> Msg) -> Cmd Msg
fetchFormations errorMsg msg =
    get "/api/formations" formationsDecoder errorMsg msg


createFormation : Formation -> (OurHttp.Error -> Msg) -> (Formation -> Msg) -> Cmd Msg
createFormation formation errorMsg msg =
    post "/api/formations" (encodeFormation formation) formationDecoder errorMsg msg


deleteFormation : Formation -> (Http.RawError -> Msg) -> (Formation -> Msg) -> Cmd Msg
deleteFormation formation errorMsg msg =
    case formation.id of
        Nothing ->
            Cmd.none

        Just id ->
            delete ("/api/formations/" ++ (toString id)) errorMsg (msg formation)


defaultRequest : String -> Http.Request
defaultRequest path =
    { verb = "GET"
    , url = path
    , body = Http.empty
    , headers = [ ( "Content-Type", "application/json" ) ]
    }


get : String -> JD.Decoder a -> (Http.Error -> Msg) -> (a -> Msg) -> Cmd Msg
get path decoder errorMsg msg =
    Http.send Http.defaultSettings
        (defaultRequest path)
        |> Http.fromJson ("data" := decoder)
        |> Task.perform errorMsg msg


post : String -> JE.Value -> JD.Decoder a -> (OurHttp.Error -> Msg) -> (a -> Msg) -> Cmd Msg
post path encoded decoder errorMsg msg =
    let
        request =
            defaultRequest path
    in
        Http.send Http.defaultSettings
            { request
                | verb = "POST"
                , body = Http.string (encoded |> JE.encode 0)
            }
            |> OurHttp.fromJson ("data" := decoder)
            |> Task.perform errorMsg msg


delete : String -> (Http.RawError -> Msg) -> Msg -> Cmd Msg
delete path errorMsg msg =
    let
        request =
            defaultRequest path
    in
        Http.send Http.defaultSettings
            { request | verb = "DELETE" }
            |> Task.perform errorMsg (always msg)


encodeFormation : Formation -> JE.Value
encodeFormation formation =
    JE.object
        [ ( "formation"
          , JE.object
                [ ( "title", JE.string formation.title )
                ]
          )
        ]
