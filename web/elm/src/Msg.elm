module Msg
    exposing
        ( Msg(..)
        , StudentMsg(..)
        , TeacherMsg(..)
        , FormationMsg(..)
        )

import Material
import Types exposing (Student, Teacher, Formation)
import Route
import Form
import Http
import OurHttp


type Msg
    = NoOp
    | StudentMsg' StudentMsg
    | TeacherMsg' TeacherMsg
    | FormationMsg' FormationMsg
    | Mdl (Material.Msg Msg)
    | NavigateTo (Maybe Route.Location)
    | SelectTab Int


type StudentMsg
    = FetchStudents
    | GotStudents (List Student)
    | NewStudentFormMsg Form.Msg
    | CreateStudentSucceeded Student
    | CreateStudentFailed OurHttp.Error
    | DeleteStudent Student
    | DeleteStudentSucceeded Student
    | DeleteStudentFailed Http.RawError


type TeacherMsg
    = FetchTeachers
    | GotTeachers (List Teacher)


type FormationMsg
    = FetchFormations
    | GotFormations (List Formation)
    | NewFormationFormMsg Form.Msg
    | CreateFormationSucceeded Formation
    | CreateFormationFailed OurHttp.Error
    | DeleteFormation Formation
    | DeleteFormationSucceeded Formation
    | DeleteFormationFailed Http.RawError
