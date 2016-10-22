module Model
    exposing
        ( Model
        , initialModel
        )

import Material
import Types exposing (User, Formation)
import Route


type alias Model =
    { mdl : Material.Model
    , route : Route.Model
    , currentTab : Int
    , users : Maybe (List User)
    , formations : Maybe (List Formation)
    }


initialModel : Maybe Route.Location -> Model
initialModel location =
    { mdl = Material.model
    , route = Route.init location
    , currentTab = 0
    , users = Nothing
    , formations = Nothing
    }
