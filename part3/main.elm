module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


main : Program () Model Msg
main =
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
        }


type alias Model =
    { field : String
    , todos : List Todo
    }


type alias Todo =
    { title : String
    }


initialModel : Model
initialModel =
    { field = ""
    , todos = []
    }



-- UPDATE


type Msg
    = Add
    | UpdateField String


update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateField todo ->
            { model | field = todo }

        Add ->
            { model
                | todos = { title = model.field } :: model.todos
                , field = ""
            }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ input
            [ placeholder "Add a todo"
            , onInput UpdateField
            , value model.field
            ]
            []
        , button [ onClick Add ] [ text "Add" ]
        , ul [] (List.map todoView model.todos)
        ]



{- TODO: Replace the placeholder "[checkbox] " text with an actual checkbox
    in `todoView` below.

   HINT:
    Most Html elements (with the exception of `text`) have the type signature
    of `List (Attribute msg) -> List (Html msg) -> Html msg`

    `type` is a keyword in elm, so the Html Attribute for setting
    this is actually `type_`
    https://package.elm-lang.org/packages/elm/html/latest/Html-Attributes#type_
-}


todoView : Todo -> Html Msg
todoView todo =
    li [ style "list-style" "none" ]
        [ text "[checkbox] "
        , text todo.title
        ]
