module Main exposing (Model, Msg(..), main, view)

import Browser
import Html exposing (..)


main : Program () Model Msg
main =
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


view : Model -> Html.Html Msg
view =
    div [] [ text model.greeting ]
