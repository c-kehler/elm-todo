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
    , todos =
        [ { title = "Learn elm" }
        ]
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
        [ input [ placeholder "Add a todo", onInput UpdateField, value model.field ] []
        , button [ onClick Add ] [ text "Add" ]
        , ul [] (List.map todoView model.todos)

        {- TODO

           We want to see how many total tasks we have.  Fix the compilation
           error occuring on the line below!

           HINT:
             text only takes 1 argument

           Types not matching up?
           See if the core library has a function to convert from one to another!
           https://package.elm-lang.org/packages/elm/core/latest/String
        -}
        , text "Number of todo tasks: " ++ List.length model.todos
        ]


todoView : Todo -> Html Msg
todoView todo =
    li [ style "list-style" "none" ]
        [ input [ type_ "checkbox" ] []
        , text todo.title
        ]
