module View.Formations.New exposing (view)

import Html exposing (..)
import Model exposing (Model)
import Msg exposing (Msg(..), FormationMsg(..))
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
            [ titleField model ]
        , cell [ size All 12 ]
            [ submitButton model
            , cancelButton model
            ]
        ]


titleField : Model -> Html Msg
titleField model =
    let
        form =
            model.newFormationForm

        title =
            Form.getFieldAsString "title" form
    in
        Textfield.render Mdl
            [ 1, 0 ]
            model.mdl
            ([ Textfield.label "Title"
             , Textfield.floatingLabel
             , Textfield.text'
             , Textfield.value <| Maybe.withDefault "" title.value
             , Textfield.onInput <| tagged << (Form.Field.Text >> Form.Input title.path)
             , Textfield.onFocus <| tagged <| Form.Focus title.path
             , Textfield.onBlur <| tagged <| Form.Blur title.path
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
        , Button.onClick <| NavigateTo <| Just Formations
        , Options.css "margin-left" "1rem"
        ]
        [ text "Cancel" ]


tagged : Form.Msg -> Msg
tagged =
    FormationMsg' << NewFormationFormMsg
