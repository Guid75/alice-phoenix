module API
    exposing
        ( fetchStudents
        , createStudent
        , deleteStudent
        , fetchTeachers
        , fetchFormations
        , createFormation
        , deleteFormation
        )

import Json.Encode as JE
import Json.Decode as JD
import Http
import Task
import Msg exposing (Msg(..), StudentMsg(..), TeacherMsg(..), FormationMsg(..))
import Decoders
    exposing
        ( studentDecoder
        , studentsDecoder
        , teachersDecoder
        , formationDecoder
        , formationsDecoder
        )
import Json.Decode exposing ((:=))
import Types exposing (Student, Teacher, Formation)
import OurHttp


fetchStudents : (Http.Error -> Msg) -> (List Student -> Msg) -> Cmd Msg
fetchStudents errorMsg msg =
    get "/api/students" studentsDecoder errorMsg msg


createStudent : Student -> (OurHttp.Error -> Msg) -> (Student -> Msg) -> Cmd Msg
createStudent student errorMsg msg =
    post "/api/students" (encodeStudent student) studentDecoder errorMsg msg


deleteStudent : Student -> (Http.RawError -> Msg) -> (Student -> Msg) -> Cmd Msg
deleteStudent student errorMsg msg =
    case student.id of
        Nothing ->
            Cmd.none

        Just id ->
            delete ("/api/students/" ++ (toString id)) errorMsg (msg student)


fetchTeachers : (Http.Error -> Msg) -> (List Teacher -> Msg) -> Cmd Msg
fetchTeachers errorMsg msg =
    get "/api/teachers" teachersDecoder errorMsg msg


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


encodeStudent : Student -> JE.Value
encodeStudent student =
    JE.object
        [ ( "student"
          , JE.object
                [ ( "firstName", JE.string student.firstName )
                , ( "lastName", JE.string student.lastName )
                ]
          )
        ]
