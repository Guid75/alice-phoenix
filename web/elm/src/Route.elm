module Route exposing (..)

import String exposing (split)
import Navigation


type Location
    = Home
    | Users
    | NewUser
    | Formations
    | NewFormation


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

                Users ->
                    "/users"

                NewUser ->
                    "/users/new"

                -- ShowUser id ->
                --     "/users/" ++ (toString id)

                -- EditUser id ->
                --     "/users/" ++ (toString id) ++ "/edit"

                Formations ->
                    "/formations"

                NewFormation ->
                    "/formations/new"

                -- ShowOrganization id ->
                --     "/organizations/" ++ (toString id)

                -- EditOrganization id ->
                --     "/organizations/" ++ (toString id) ++ "/edit"
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

            [ "users" ] ->
                Just Users

            [ "users", "new" ] ->
                Just NewUser

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
