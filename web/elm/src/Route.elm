module Route exposing (..)

import String exposing (split)
import Navigation


type Location
    = Home
    | Students
    | NewStudent
    | Formations
    | NewFormation
    | Workshops


type alias Model =
    Maybe Location


init : Maybe Location -> Model
init location =
    location

urlFor : Location -> String
urlFor loc =
    let
        url =
            case loc of
                Home ->
                    "/"

                Students ->
                    "/students"

                NewStudent ->
                    "/students/new"

                -- ShowStudent id ->
                --     "/users/" ++ (toString id)

                -- EditStudent id ->
                --     "/users/" ++ (toString id) ++ "/edit"

                Formations ->
                    "/formations"

                NewFormation ->
                    "/formations/new"

                -- ShowOrganization id ->
                --     "/organizations/" ++ (toString id)

                -- EditOrganization id ->
                --     "/organizations/" ++ (toString id) ++ "/edit"
                Workshops ->
                    "/workshops"
    in
        "#" ++ url


locFor : Navigation.Location -> Maybe Location
locFor path =
    let
        segments =
            path.hash
                |> split "/"
                |> List.filter (\seg -> seg /= "" && seg /= "#")
    in
        case segments of
            [] ->
                Just Home

            [ "students" ] ->
                Just Students

            [ "students", "new" ] ->
                Just NewStudent

            -- [ "users", stringId ] ->
            --     case String.toInt stringId of
            --         Ok id ->
            --             Just (ShowUser id)
            --         Err _ ->
            --             Nothing
            -- [ "users", stringId, "edit" ] ->
            --     String.toInt stringId
            --         |> Result.toMaybe
            --         |> Maybe.map EditUser
            [ "formations" ] ->
                Just Formations

            [ "formations", "new" ] ->
                Just NewFormation

            [ "workshops" ] ->
                Just Workshops

            -- [ "organizations", stringId ] ->
            --     case String.toInt stringId of
            --         Ok id ->
            --             Just (ShowOrganization id)
            --         Err _ ->
            --             Nothing
            -- [ "organizations", stringId, "edit" ] ->
            --     String.toInt stringId
            --         |> Result.toMaybe
            --         |> Maybe.map EditOrganization
            _ ->
                Nothing
