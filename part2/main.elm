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

        {- TODO: Fix the `Add` case so that we don't lose any todos from
            the model

           HINT:
            Some of the basic operators that are supplied by the elm core
            library like `+` are called infix operators. This means that
            the operator is placed between the arguments (e.g. 1 + 2)

            This is denoted by the parentheses around the operator name in
            the docs
              (+) : number -> number -> number
              https://package.elm-lang.org/packages/elm/core/latest/Basics#(+)

            If we want to add two lists together, we would use this function
              (++) : appendable -> appendable -> appendable
              https://package.elm-lang.org/packages/elm/core/latest/Basics#(++)
        -}
        Add ->
            { model
                | todos = [ { title = model.field } ]
                , field = ""
            }



-- VIEW


todoView : Todo -> Html Msg
todoView todo =
    li []
        [ text todo.title ]


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
        , ul [] (model.todos |> List.map todoView)
        ]
