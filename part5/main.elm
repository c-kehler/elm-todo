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
    , todos =
        [ { title = "Learn elm"
          , checked = False
          }
        ]
    }



-- TYPES


type alias Todo =
    { title : String
    , checked : Bool
    }



-- UPDATE


type Msg
    = Add
    | UpdateField String
    | ToggleCheck String Bool


update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateField todo ->
            { model | field = todo }

        Add ->
            { model
                | todos =
                    { title = model.field
                    , checked = False
                    }
                        :: model.todos
                , field = ""
            }

        ToggleCheck todoName _ ->
            let
                flipChecked : Todo -> Todo
                flipChecked todo =
                    { todo | checked = not todo.checked }

                updatedTodos =
                    List.map
                        (\t ->
                            if t.title == todoName then
                                flipChecked t

                            else
                                t
                        )
                        model.todos
            in
            { model | todos = updatedTodos }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ input [ placeholder "Add a todo", onInput UpdateField, value model.field ] []
        , button [ onClick Add ] [ text "Add" ]
        , ul [] (List.map todoView model.todos)
        , text <| "Number of todo tasks: " ++ (String.fromInt <| List.length model.todos)
        ]


todoView : Todo -> Html Msg
todoView todo =
    li [ style "list-style" "none" ]
        [ input [ type_ "checkbox", onCheck <| ToggleCheck todo.title ] []
        , span
            [ style "font-size" "1em"
            , style "color" "slateblue"

            {- TODO:
               We want to make sure the user knows that checked items are done
               Conditionally apply css on checked items

               Hint:
               We've added a new property to each Todo item so that the type is now
               { title: String, checked: Bool }

               Using this new property, we need to check if it is set to True and
               apply a style

               Whatever we add to this list should have the same type as the
               previous elements (Html.Attribute)
            -}
            ]
            [ text todo.title ]
        ]
