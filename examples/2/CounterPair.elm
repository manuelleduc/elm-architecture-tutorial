module CounterPair exposing (..)

import Counter
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html.App exposing (map)


-- MODEL

type alias Model =
    { topCounter : Counter.Model
    , bottomCounter : Counter.Model
    }


init : Int -> Int -> Model
init top bottom =
    { topCounter = Counter.init top
    , bottomCounter = Counter.init bottom
    }


-- UPDATE

type Msg
    = Reset
    | Top Counter.Msg
    | Bottom Counter.Msg


update : Msg -> Model -> Model
update action model =
  case action of
    Reset -> init 0 0

    Top act ->
      { model |
          topCounter = Counter.update act model.topCounter
      }

    Bottom act ->
      { model |
          bottomCounter = Counter.update act model.bottomCounter
      }


-- VIEW

view : Model -> Html Msg
view model =
  div []
    [ map Top (Counter.view model.topCounter)
    , map Bottom (Counter.view model.bottomCounter)
    , button [ onClick Reset ] [ text "RESET" ]
    ]
