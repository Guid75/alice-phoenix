module Msg exposing (Msg(..), UserMsg(..), FormationMsg(..))

import Material
import Types exposing (User, Formation)
import Route
import Form
import Http
import OurHttp


type Msg
    = NoOp
    | UserMsg' UserMsg
    | FormationMsg' FormationMsg
    | Mdl (Material.Msg Msg)
    | NavigateTo (Maybe Route.Location)
    | SelectTab Int


type UserMsg
    = FetchUsers
    | GotUsers (List User)


type FormationMsg
    = FetchFormations
    | GotFormations (List Formation)
    | NewFormationFormMsg Form.Msg
    | CreateFormationSucceeded Formation
    | CreateFormationFailed OurHttp.Error
    | DeleteFormation Formation
    | DeleteFormationSucceeded Formation
    | DeleteFormationFailed Http.RawError
