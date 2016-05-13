import RandomGifPair exposing (init, update, view)
import Html.App as Html

main =
  Html.program
    { init = init "funny cats" "funny dogs"
    , update = update
    , view = view
    , subscriptions = \_ -> Sub.none
    }
