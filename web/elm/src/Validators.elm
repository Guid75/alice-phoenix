module Validators
    exposing
        ( validateNewFormation
        , validateNewStudent
        )

import Form.Validate exposing (Validation, form1, form2, get, string)
import Types exposing (Formation, Student, Teacher)


validateNewFormation : Validation String Formation
validateNewFormation =
    form1 (Formation Nothing)
        (get "title" string)


validateNewStudent : Validation String Student
validateNewStudent =
    form2 (Student Nothing)
        (get "firstName" string)
        (get "lastName" string)
