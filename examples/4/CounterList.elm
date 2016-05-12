module CounterList exposing (..)

import Counter
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


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

type Action
    = Insert
    | Remove ID
    | Modify ID Counter.Action


update : Action -> Model -> Model
update action model =
  case action of
    Insert ->
      { model |
          counters = ( model.nextID, Counter.init 0 ) :: model.counters,
          nextID = model.nextID + 1
      }

    Remove id ->
      { model |
          counters = List.filter (\(counterID, _) -> counterID /= id) model.counters
      }

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
  let insert = button [ onClick Insert ] [ text "Add" ]
  in
      div [] (insert :: List.map (viewCounter) model.counters)


viewCounter : (ID, Counter.Model) -> Html Msg
viewCounter (id, model) =
  let context =
        Counter.Context
          (map  (Modify id))
          (map (always (Remove id)))
  in
      Counter.viewWithRemoveButton context model
