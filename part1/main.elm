module Main exposing (main)

import Browser
import Html exposing (..)



{- TODO: Set greeting equal to "hello world"

   NOTE:
     Remember `init` runs when our Elm app initializes. This is a barebones
     of example of how you would start an Elm with preset configurations.
-}


main : Program () Model Msg
main =
    Browser.sandbox
        { init = initialModel
        , update = update
        , view = view
        }


type alias Model =
    { greeting : String }


initialModel : Model
initialModel =
    { greeting = "" }


type Msg
    = None


update : Msg -> Model -> Model
update msg model =
    case msg of
        _ ->
            model



{- TODO: Get the `view` function to compile.

   HINT:
     Look at the type signature. This function is supposed to take in a
     `Model` argument, and output an `Html Msg`
-}


view : Model -> Html Msg
view =
    div [] [ text model.greeting ]
