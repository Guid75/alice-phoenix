module Model
    exposing
        ( Model
        , initialModel
        )

import Material
import Types exposing (Student, Teacher, Formation)
import Route
import Form exposing (Form)
import Validators


type alias Model =
    { mdl : Material.Model
    , route : Route.Model
    , currentTab : Int
    , students : Maybe (List Student)
    , newStudentForm : Form String Student
    , teachers : Maybe (List Teacher)
    , formations : Maybe (List Formation)
    , newFormationForm : Form String Formation
    }


initialModel : Maybe Route.Location -> Model
initialModel location =
    { mdl = Material.model
    , route = Route.init location
    , currentTab = 0
    , students = Nothing
    , newStudentForm = Form.initial [] Validators.validateNewStudent
    , teachers = Nothing
    , formations = Nothing
    , newFormationForm = Form.initial [] Validators.validateNewFormation
    }
