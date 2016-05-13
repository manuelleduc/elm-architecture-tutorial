module Counter exposing (Msg(..), Model, init, update, view)

import Html exposing (..)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)


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


countStyle : Attribute a
countStyle =
  style
    [ ("font-size", "20px")
    , ("font-family", "monospace")
    , ("display", "inline-block")
    , ("width", "50px")
    , ("text-align", "center")
    ]
