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


type Msg
    = Add
    | UpdateField String


initialModel : Model
initialModel =
    { field = ""
    , todos = []
    }


view : Model -> Html Msg
view model =
    div []
        [ input [ placeholder "Add a todo", onInput UpdateField, value model.field ] []
        , button [ onClick Add ] [ text "Add" ]
        , ul [] (model.todos |> List.map renderTodo)
        ]


renderTodo : Todo -> Html Msg
renderTodo todo =
    li []
        [ text todo.title ]


update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateField todo ->
            { model | field = todo }

        -- TODO: The problem line is here. How come the TODO list can only hold one item at a time?
        Add ->
            { model
                | todos = { title = model.field } :: []
                , field = ""
            }


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.batch
        []
