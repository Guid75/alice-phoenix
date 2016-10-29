module Types
    exposing
        ( Student
        , Teacher
        , Formation
        )

type alias Student =
    { id : Maybe Int
    , firstName : String
    , lastName : String
    }


type alias Teacher =
    { id : Maybe Int
    , firstName : String
    , lastName : String
    }


type alias Admin =
    { id : Maybe Int
    , firstName : String
    , lastName : String
    }


type alias Formation =
    { id : Maybe Int
    , title : String
    }
