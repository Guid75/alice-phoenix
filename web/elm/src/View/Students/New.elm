module View.Students.New exposing (view)

import Html exposing (..)
import Model exposing (Model)
import Msg exposing (Msg(..), StudentMsg(..))
import Material.Button as Button
import Material.Textfield as Textfield
import Material.Grid exposing (grid, cell, size, Device(..), offset)
import Material.Options as Options
import Form exposing (Form)
import Form.Field
import Form.Input
import Form.Error
import Route exposing (Location(..))


view : Model -> Html Msg
view model =
    grid []
        [ cell [ size All 12 ]
            [ firstNameField model
            ]
        , cell [ size All 12 ]
            [ lastNameField model ]
        , cell [ size All 12 ]
            [ submitButton model
            , cancelButton model
            ]
        ]


firstNameField : Model -> Html Msg
firstNameField model =
    let
        form =
            model.newStudentForm

        firstName =
            Form.getFieldAsString "firstName" form
    in
        Textfield.render Mdl
            [ 0 ]
            model.mdl
            ([ Textfield.label "First name"
             , Textfield.floatingLabel
             , Textfield.text'
             , Textfield.value <| Maybe.withDefault "" firstName.value
             , Textfield.onInput <| tagged << (Form.Field.Text >> Form.Input firstName.path)
             , Textfield.onFocus <| tagged <| Form.Focus firstName.path
             , Textfield.onBlur <| tagged <| Form.Blur firstName.path
             ]
             -- ++ OurForm.errorMessagesForTextfield name
            )


lastNameField : Model -> Html Msg
lastNameField model =
    let
        form =
            model.newStudentForm

        lastName =
            Form.getFieldAsString "lastName" form
    in
        Textfield.render Mdl
            [ 1 ]
            model.mdl
            ([ Textfield.label "Last name"
             , Textfield.floatingLabel
             , Textfield.text'
             , Textfield.value <| Maybe.withDefault "" lastName.value
             , Textfield.onInput <| tagged << (Form.Field.Text >> Form.Input lastName.path)
             , Textfield.onFocus <| tagged <| Form.Focus lastName.path
             , Textfield.onBlur <| tagged <| Form.Blur lastName.path
             ]
             -- ++ OurForm.errorMessagesForTextfield name
            )


submitButton : Model -> Html Msg
submitButton model =
    Button.render Mdl
        [ 1, 1 ]
        model.mdl
        [ Button.raised
        , Button.ripple
        , Button.colored
        , Button.onClick <| tagged Form.Submit
        ]
        [ text "Submit" ]


cancelButton : Model -> Html Msg
cancelButton model =
    Button.render Mdl
        [ 1, 2 ]
        model.mdl
        [ Button.ripple
        , Button.onClick <| NavigateTo <| Just Students
        , Options.css "margin-left" "1rem"
        ]
        [ text "Cancel" ]


tagged : Form.Msg -> Msg
tagged =
    StudentMsg' << NewStudentFormMsg
