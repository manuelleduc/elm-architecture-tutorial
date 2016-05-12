module CounterList exposing (..)

import Counter
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html.App exposing (map)

-- MODEL

type alias Model =
    { counters : List ( ID, Counter.Model )
    , nextID : ID
    }

type alias ID = Int


init : Model
init =
    { counters = []
    , nextID = 0
    }


-- UPDATE

type Msg
    = Insert
    | Remove
    | Modify ID Counter.Msg


update : Msg -> Model -> Model
update action model =
  case action of
    Insert ->
      let newCounter = ( model.nextID, Counter.init 0 )
          newCounters = model.counters ++ [ newCounter ]
      in
          { model |
              counters = newCounters,
              nextID = model.nextID + 1
          }

    Remove ->
      { model | counters = List.drop 1 model.counters }

    Modify id counterAction ->
      let updateCounter (counterID, counterModel) =
              if counterID == id then
                  (counterID, Counter.update counterAction counterModel)
              else
                  (counterID, counterModel)
      in
          { model | counters = List.map updateCounter model.counters }


-- VIEW

view : Model -> Html Msg
view model =
  let counters = List.map (viewCounter) model.counters
      remove = button [ onClick Remove ] [ text "Remove" ]
      insert = button [ onClick Insert ] [ text "Add" ]
  in
      div [] ([remove, insert] ++ counters)


viewCounter : (ID, Counter.Model) -> Html Msg
viewCounter (id, model) =
  map (Modify id) (Counter.view model)
