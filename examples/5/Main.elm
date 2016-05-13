import RandomGif exposing (init, update, view)
import Html.App as Html
import Task


main =
  Html.program
    { init = init "funny cats"
    , update = update
    , view = view
  --  , inputs = []
    , subscriptions = \_ -> Sub.none
    }
