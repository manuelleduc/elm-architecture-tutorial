module RandomGifPair exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App exposing (map)

import RandomGif


-- MODEL

type alias Model =
    { left : RandomGif.Model
    , right : RandomGif.Model
    }


init : String -> String -> (Model, Cmd Msg)
init leftTopic rightTopic =
  let
    (left, leftFx) = RandomGif.init leftTopic
    (right, rightFx) = RandomGif.init rightTopic
  in
    ( Model left right
    , Cmd.batch
        [ Cmd.map Left leftFx
        , Cmd.map Right rightFx
        ]
    )


-- UPDATE

type Msg
    = Left RandomGif.Msg
    | Right RandomGif.Msg


update : Msg -> Model -> (Model, Cmd Msg)
update action model =
  case action of
    Left act ->
      let
        (left, fx) = RandomGif.update act model.left
      in
        ( Model left model.right
        , Cmd.map Left fx
        )

    Right act ->
      let
        (right, fx) = RandomGif.update act model.right
      in
        ( Model model.left right
        , Cmd.map Right fx
        )


-- VIEW

view : Model -> Html Msg
view model =
  div [ style [ ("display", "flex") ] ]
    [ map Left (RandomGif.view model.left)
    , map Right (RandomGif.view model.right)
    ]
