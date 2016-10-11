module View.Formations exposing (view)

import Model exposing (Model)

import Html exposing (div)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)

view : Model -> Html Msg
view model =
    div
        []
        (List.map
            (\formation ->
                div
                    [ style
                        [ ( "color", "red" )
                        ]
                    ]
                    [ text formation ]
            )
            model.formations
        )
