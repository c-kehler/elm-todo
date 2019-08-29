module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html.Keyed exposing (ul)


main : Program () Model Msg
main =
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
        }


type alias Model =
    { field : String
    , filter : Visibility
    , todos : List Todo
    }


type alias Todo =
    { id : Int
    , title : String
    , completed : Bool
    }


type Visibility
    = All
    | Completed
    | Active


type Msg
    = Add
    | UpdateField String
    | Toggle Int
    | SetVisibility Visibility


initialModel : Model
initialModel =
    { field = ""
    , filter = All
    , todos = []
    }


view : Model -> Html Msg
view model =
    div []
        [ input [ placeholder "Add a todo", onInput UpdateField, value model.field ] []
        , button [ onClick Add ] [ text "Add" ]
        , Html.Keyed.ul []
            (model.todos
                |> List.filter (filterTodo model.filter)
                |> List.map renderTodo
            )
        , model.todos
            |> itemsLeft
            |> String.fromInt
            |> String.append "Item left : "
            |> text
        , filterView model.filter
        ]


filterTodo : Visibility -> Todo -> Bool
filterTodo visibility todo =
    case visibility of
        All ->
            True

        Active ->
            not todo.completed

        Completed ->
            todo.completed


itemsLeft : List Todo -> Int
itemsLeft todos =
    let
        nbCompleted : Int
        nbCompleted =
            List.foldl
                (\item count ->
                    if item.completed then
                        count + 1

                    else
                        count
                )
                0
                todos
    in
    List.length todos - nbCompleted


renderTodo : Todo -> ( String, Html Msg )
renderTodo todo =
    let
        lineThroughStyle =
            if todo.completed then
                Html.Attributes.style "text-decoration" "line-through"

            else
                Html.Attributes.style "" ""
    in
    ( String.fromInt todo.id
    , li
        [ lineThroughStyle
        ]
        [ input
            [ type_ "checkbox"
            , onClick (Toggle todo.id)
            , checked todo.completed
            ]
            []
        , text todo.title
        ]
    )



-- TODO: Get this function to compile correctly
-- NOTE: This can be fixed in several different ways!


filterView : Visibility -> Html Msg
filterView visibility =
    let
        underlineAttr filter =
            if visibility == filter then
                [ ( "text-decoration", "underline" ) ]

            else
                []
    in
    div []
        [ a
            [ onClick (SetVisibility All)
            , style (underlineAttr All)
            ]
            [ text "  All  " ]
        , a
            [ onClick (SetVisibility Completed)
            , style (underlineAttr Completed)
            ]
            [ text "  Completed  " ]
        , a
            [ onClick (SetVisibility Active)
            , style (underlineAttr Active)
            ]
            [ text "  Active  " ]
        ]


update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateField todo ->
            { model | field = todo }

        Add ->
            let
                nextId : Int
                nextId =
                    case List.head model.todos of
                        Nothing ->
                            0

                        Just todo ->
                            todo.id + 1
            in
            { model
                | todos =
                    { id = nextId
                    , title = model.field
                    , completed = False
                    }
                        :: model.todos
                , field = ""
            }

        Toggle id ->
            let
                updateTodo todo =
                    if todo.id == id then
                        { todo | completed = not todo.completed }

                    else
                        todo
            in
            { model | todos = List.map updateTodo model.todos }

        SetVisibility visibility ->
            { model | filter = visibility }
