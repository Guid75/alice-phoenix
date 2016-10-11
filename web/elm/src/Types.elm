module Types
    exposing
        ( User
        , Formation
        )

-- type alias Student =
--     { id : Maybe Int
--     , firstName : String
--     , lastName : String
--     }
-- type alias Teacher =
--     { id : Maybe Int
--     , firstName : String
--     , lastName : string
--     }


type alias User =
    { id : Maybe Int
    , firstName : String
    , lastName : String
    }


type Profile
    = Admin
    | Teacher
    | Student


type alias Formation =
    { id : Maybe Int
    , title : String
    }
