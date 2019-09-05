module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)



-- MAIN


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


initialModel : Model
initialModel =
    { field = ""
    , todos = []
    }



-- TYPES


type alias Todo =
    { title : String
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


todoView : Todo -> Html Msg
todoView todo =
    li [ style "list-style" "none" ]
        [ {- TODO: Replace this text "checkbox" with an actual checkbox.

             HINT:
               Html.text has a type of `String -> Html Msg`
               https://package.elm-lang.org/packages/elm/html/latest/Html#text

               However, most other elements have a type of
               `List (Attribute msg) -> List (Html msg) -> Html msg`
               https://package.elm-lang.org/packages/elm/html/latest/Html#input
          -}
          text "checkbox"
        , text todo.title
        ]
