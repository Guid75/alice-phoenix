module Decoders
    exposing
        ( studentDecoder
        , studentsDecoder
        , teacherDecoder
        , teachersDecoder
        , formationDecoder
        , formationsDecoder
        )

import Json.Decode exposing (int, list, string, Decoder)
import Json.Decode.Pipeline exposing (decode, required, optional, hardcoded, nullable)
import Types exposing (Student, Teacher, Formation)


studentsDecoder : Decoder (List Student)
studentsDecoder =
    list studentDecoder


studentDecoder : Decoder Student
studentDecoder =
    decode Student
        |> required "id" (nullable int)
        |> required "firstName" string
        |> required "lastName" string


teachersDecoder : Decoder (List Teacher)
teachersDecoder =
    list teacherDecoder


teacherDecoder : Decoder Teacher
teacherDecoder =
    decode Teacher
        |> required "id" (nullable int)
        |> required "firstName" string
        |> required "lastName" string


formationsDecoder : Decoder (List Formation)
formationsDecoder =
    list formationDecoder


formationDecoder : Decoder Formation
formationDecoder =
    decode Formation
        |> required "id" (nullable int)
        |> required "title" string
