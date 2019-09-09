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
    div []
        [ input
            [ placeholder "Add a todo"
            , onInput UpdateField
            , value model.field
            ]
            []
        , button [ onClick Add ] [ text "Add" ]
        , Html.Keyed.ul [] (List.map todoView model.todos)
        , text ("Total number of tasks: " ++ String.fromInt (List.length model.todos))
        ]



{- TODO:
   We want to make sure the user knows that checked items are done
   Conditionally apply css on checked items

   HINT:
    We've added new properties to each Todo record so that the type
    is now `{ id: Int, title: String, checked: Bool }`

    Using this new property, we need to check if the value is `True`
    and apply a style such as `text-decoration: line-through;`

   HINT:
    Conditionals in elm can be done with
      if ... then
        ...
      else
        ...
    or
      case ... of
        ... -> ...
        ... -> ...

    All of the cases must evaluate to the same type
    https://elm-lang.org/docs/syntax#conditionals

   HINT:
    Whatever we add to this list should have the same type as the
    previous elements (Html.Attribute)

-}


todoView : Todo -> ( String, Html Msg )
todoView todo =
    ( String.fromInt todo.id
    , li [ style "list-style" "none" ]
        [ input [ type_ "checkbox", onCheck <| SetCheckStatus todo.id ] []
        , span
            [ style "font-size" "1em"
            , style "color" "slateblue"
            ]
            [ text todo.title ]
        ]
    )
