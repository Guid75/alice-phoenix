module API
    exposing
        ( fetchUsers
        , fetchFormations
        )

import Http
import Task
import Msg exposing (Msg(..), UserMsg(..), FormationMsg(..))
import Decoders exposing (usersDecoder, formationsDecoder)
import Types exposing (User, Formation)


fetchUsers : (Http.Error -> Msg) -> (List User -> Msg) -> Cmd Msg
fetchUsers errorMsg msg =
    Task.perform errorMsg msg (Http.get usersDecoder "/api/users")


fetchFormations : (Http.Error -> Msg) -> (List Formation -> Msg) -> Cmd Msg
fetchFormations errorMsg msg =
    Task.perform errorMsg msg (Http.get formationsDecoder "/api/formations")
