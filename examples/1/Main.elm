
import Counter exposing (update, view)
import Html.App as Html
import Html.App exposing (beginnerProgram)

main =
  beginnerProgram
    { model = 0
    , update = update
    , view = view
    }
