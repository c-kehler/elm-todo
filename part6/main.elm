module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html.Keyed



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
    , todos =
        [ { id = 1
          , title = "Learn elm"
          , checked = False
          }
        ]
    }



-- TYPES


type alias Todo =
    { id : Int
    , title : String
    , checked : Bool
    }



-- UPDATE


type Msg
    = Add
    | UpdateField String
    | SetCheckStatus Int Bool


update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateField todo ->
            { model | field = todo }

        Add ->
            let
                nextId : Int
                nextId =
                    List.map .id model.todos
                        |> List.maximum
                        |> Maybe.withDefault 0
                        |> (+) 1
            in
            { model
                | todos =
                    { id = nextId
                    , title = model.field
                    , checked = False
                    }
                        :: model.todos
                , field = ""
            }

        SetCheckStatus todoId isChecked ->
            let
                updateTodo : Todo -> Todo
                updateTodo todo =
                    if todo.id == todoId then
                        { todo | checked = isChecked }

                    else
                        todo
            in
            { model | todos = List.map updateTodo model.todos }



-- VIEW


view : Model -> Html Msg
view model =
    let
        tasksLeftMessage : String
        tasksLeftMessage =
            case countIncomplete model.todos of
                0 ->
                    "All done!"

                numTasks ->
                    "Number of tasks left: " ++ String.fromInt numTasks
    in
    div []
        [ input
            [ placeholder "Add a todo"
            , onInput UpdateField
            , value model.field
            ]
            []
        , button [ onClick Add ] [ text "Add" ]
        , Html.Keyed.ul [] (List.map todoView model.todos)
        , text tasksLeftMessage
        ]



{- TODO: Fix the `countIncomplete` function to return the number of tasks that
    are unchecked.

   HINT:
    The syntax
      let ... in
    allows us to abstract some code from the result while keeping it in the
    same function

    Can you find the 2 List functions that could be used to get `List Todo`
    narrowed down to only the unchecked `List Todo` and then to `Int`?
    https://package.elm-lang.org/packages/elm/core/latest/List
-}


countIncomplete : List Todo -> Int
countIncomplete todos =
    -1


todoView : Todo -> ( String, Html Msg )
todoView todo =
    ( String.fromInt todo.id
    , li [ style "list-style" "none" ]
        [ input [ type_ "checkbox", onCheck <| SetCheckStatus todo.id ] []
        , span
            [ style "font-size" "1em"
            , style "color" "slateblue"
            , if todo.checked then
                style "text-decoration" "line-through"

              else
                style "" ""
            ]
            [ text todo.title ]
        ]
    )
