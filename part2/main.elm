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
            {- TODO: Change how this title is being set so that the todo list
               is being appended to instead of replaced.

               HINT:
                 Adding an element to the front of the list is called cons (::)
                 https://package.elm-lang.org/packages/elm/core/latest/List#(::)
            -}
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
