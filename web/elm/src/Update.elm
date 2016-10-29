module Update exposing (update)

import Material
import Navigation
import Model exposing (Model)
import Msg exposing (Msg(..), StudentMsg(..), TeacherMsg(..), FormationMsg(..))
import API
import Route exposing (Location(..))
import Form


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Mdl msg' ->
            Material.update msg' model

        StudentMsg' msg ->
            updateStudentMsg msg model

        TeacherMsg' msg ->
            updateTeacherMsg msg model

        FormationMsg' msg ->
            updateFormationMsg msg model

        SelectTab tab ->
            case tab of
                0 ->
                    model ! [ Navigation.newUrl (Route.urlFor Formations) ]

                1 ->
                    model ! [ Navigation.newUrl (Route.urlFor Students) ]

                _ ->
                    model ! [ Navigation.newUrl (Route.urlFor Home) ]

        NavigateTo maybeLocation ->
            case maybeLocation of
                Nothing ->
                    model ! []

                Just location ->
                    model ! [ Navigation.newUrl (Route.urlFor location) ]

        NoOp ->
            model ! []


updateStudentMsg : StudentMsg -> Model -> ( Model, Cmd Msg )
updateStudentMsg msg model =
    case msg of
        FetchStudents ->
            model ! [ API.fetchStudents (always NoOp) (StudentMsg' << GotStudents) ]

        GotStudents students ->
            { model | students = Just students } ! []

        CreateStudentFailed error ->
            model ! []

        CreateStudentSucceeded student ->
            { model | newStudentForm = (Model.initialModel Nothing).newStudentForm } ! [ Navigation.newUrl (Route.urlFor Students) ]

        NewStudentFormMsg formMsg ->
            case ( formMsg, Form.getOutput model.newStudentForm ) of
                ( Form.Submit, Just student ) ->
                    model ! [ API.createStudent student (StudentMsg' << CreateStudentFailed) (StudentMsg' << CreateStudentSucceeded) ]

                _ ->
                    { model | newStudentForm = Form.update formMsg model.newStudentForm } ! []

        DeleteStudent organization ->
            model ! [ API.deleteStudent organization (StudentMsg' << DeleteStudentFailed) (StudentMsg' << DeleteStudentSucceeded) ]

        DeleteStudentFailed error ->
            model ! []

        DeleteStudentSucceeded organization ->
            model ! [ API.fetchStudents (always NoOp) (StudentMsg' << GotStudents) ]



updateTeacherMsg : TeacherMsg -> Model -> ( Model, Cmd Msg )
updateTeacherMsg msg model =
    case msg of
        FetchTeachers ->
            model ! [ API.fetchTeachers (always NoOp) (TeacherMsg' << GotTeachers) ]

        GotTeachers students ->
            { model | students = Just students } ! []


updateFormationMsg : FormationMsg -> Model -> ( Model, Cmd Msg )
updateFormationMsg msg model =
    case Debug.log "updateFormationMsg" msg of
        FetchFormations ->
            model ! [ API.fetchFormations (always NoOp) (FormationMsg' << GotFormations) ]

        GotFormations formations ->
            { model | formations = Just formations } ! []

        CreateFormationFailed error ->
            model ! []

        CreateFormationSucceeded formation ->
            { model | newFormationForm = (Model.initialModel Nothing).newFormationForm } ! [ Navigation.newUrl (Route.urlFor Formations) ]

        NewFormationFormMsg formMsg ->
            case ( formMsg, Form.getOutput model.newFormationForm ) of
                ( Form.Submit, Just formation ) ->
                    model ! [ API.createFormation formation (FormationMsg' << CreateFormationFailed) (FormationMsg' << CreateFormationSucceeded) ]

                _ ->
                    { model | newFormationForm = Form.update formMsg model.newFormationForm } ! []

        DeleteFormation organization ->
            model ! [ API.deleteFormation organization (FormationMsg' << DeleteFormationFailed) (FormationMsg' << DeleteFormationSucceeded) ]

        DeleteFormationFailed error ->
            model ! []

        DeleteFormationSucceeded organization ->
            model ! [ API.fetchFormations (always NoOp) (FormationMsg' << GotFormations) ]
