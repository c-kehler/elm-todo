module Main exposing (Flags, Model, Msg(..), Todo, Visibility(..), initialModel, main, renderTodo, subscriptions, update, view)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


main : Program Flags Model Msg
main =
    Browser.element
        { init = initialModel
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias Model =
    { field : String
    , todos : List Todo
    }


type alias Todo =
    { title : String
    }


type Visibility
    = All
    | Completed
    | Active


type Msg
    = Add
    | UpdateField String


type alias Flags =
    {}


initialModel : Flags -> ( Model, Cmd Msg )
initialModel flags =
    ( { field = ""
      , todos = []
      }
    , Cmd.none
    )


view : Model -> Html.Html Msg
view model =
    div []
        [ input [ placeholder "Add a todo", onInput UpdateField, value model.field ] []
        , button [ onClick Add ] [ text "Add" ]
        , ul [] (model.todos |> List.map renderTodo)
        ]


renderTodo : Todo -> Html.Html Msg
renderTodo todo =
    li []
        [ text todo.title ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateField todo ->
            ( { model | field = todo }, Cmd.none )

        -- TODO: The problem line is here. How come the TODO list can only hold one item at a time?
        Add ->
            ( { model
                | todos = { title = model.field } :: []
                , field = ""
              }
            , Cmd.none
            )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.batch
        []
