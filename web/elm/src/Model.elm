module Model
    exposing
        ( Model
        , initialModel
        )

import Material
import Types exposing (User, Formation)


type alias Model =
    { mdl : Material.Model
    , tab : Int
    , users : Maybe (List User)
    , formations : Maybe (List Formation)
    }


initialModel : Model
initialModel =
    { mdl = Material.model
    , tab = 0
    , users = Nothing
    , formations = Nothing
    }
