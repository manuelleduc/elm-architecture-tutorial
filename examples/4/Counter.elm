module Counter exposing (Model, init, Msg, update, view, viewWithRemoveButton, Context)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)



-- MODEL

type alias Model = Int


init : Int -> Model
init count = count


-- UPDATE

type Msg = Increment | Decrement


update : Msg -> Model -> Model
update action model =
  case action of
    Increment ->
      model + 1

    Decrement ->
      model - 1


-- VIEW

view : Model -> Html Msg
view model =
  div []
    [ button [ onClick Decrement ] [ text "-" ]
    , div [ countStyle ] [ text (toString model) ]
    , button [ onClick Increment ] [ text "+" ]
    ]


type alias Context p =
    { msgs : Msg -> p
    , remove : p
    }


viewWithRemoveButton : Context p -> Model -> Html p
viewWithRemoveButton context model =
  div []
    [ button [ onClick (context.msgs Decrement) ] [ text "-" ]
    , div [ countStyle ] [ text (toString model) ]
    , button [ onClick (context.msgs Increment) ] [ text "+" ]
    , div [ countStyle ] []
    , button [ onClick context.remove ] [ text "X" ]
    ]


countStyle : Attribute a
countStyle =
  style
    [ ("font-size", "20px")
    , ("font-family", "monospace")
    , ("display", "inline-block")
    , ("width", "50px")
    , ("text-align", "center")
    ]
