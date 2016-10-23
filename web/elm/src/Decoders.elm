module Decoders exposing (usersDecoder, formationsDecoder, formationDecoder)

import Json.Decode as JD exposing ((:=))
import Types exposing (User, Formation)


-- TODO: remove the JSON.at() by moving the removal logic into the API


usersDecoder : JD.Decoder (List User)
usersDecoder =
    JD.at [ "data" ] <| JD.list userDecoder


userDecoder : JD.Decoder User
userDecoder =
    JD.object3 User
        (JD.maybe ("id" := JD.int))
        ("firstName" := JD.string)
        ("lastName" := JD.string)


formationsDecoder : JD.Decoder (List Formation)
formationsDecoder =
    JD.list formationDecoder


formationDecoder : JD.Decoder Formation
formationDecoder =
    JD.object2 Formation
        (JD.maybe ("id" := JD.int))
        ("title" := JD.string)
