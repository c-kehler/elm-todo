module Main exposing (Model, Msg(..), main, view)

import Browser
import Html exposing (..)


main : Program () Model Msg
main =
    {- TODO: Set greeting equal to "hello world"

       NOTE:
         Remember `init` runs when our Elm app initializes. This is a barebones
         of example of how you would start an Elm with preset configurations.
    -}
    Browser.sandbox
        { init = { greeting = "" }
        , update = update
        , view = view
        }


type alias Model =
    { greeting : String }


type Msg
    = None


update : Msg -> Model -> Model
update msg model =
    case msg of
        _ ->
            model


view : Model -> Html Msg
view =
    {- TODO: Get this function to compile.

       HINT:
         Look at the type signature. This function is supposed to take in a
         `Model` argument, and output an `Html Msg`
    -}
    div [] [ text model.greeting ]
