module Validators exposing (validateNewFormation)

import Form.Validate exposing (Validation, form1, form2, get, string)
import Types exposing (Formation)

validateNewFormation : Validation String Formation
validateNewFormation =
    form1 (Formation Nothing)
        (get "title" string)
