
import CounterPair exposing (init, update, view)
import Html.App exposing (beginnerProgram)


main =
  beginnerProgram
    { model = init 0 0
    , update = update
    , view = view
    }
