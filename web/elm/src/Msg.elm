module Msg exposing (Msg(..), UserMsg(..), FormationMsg(..))

import Material
import Types exposing (User, Formation)


type Msg
    = NoOp
    | UserMsg' UserMsg
    | FormationMsg' FormationMsg
    | Mdl (Material.Msg Msg)
    | SelectTab Int


type UserMsg
    = FetchUsers
    | GotUsers (List User)


type FormationMsg
    = FetchFormations
    | GotFormations (List Formation)
