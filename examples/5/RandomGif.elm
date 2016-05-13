module RandomGif exposing (..)

import Html exposing (..)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Http
import Json.Decode as Json
import Task


-- MODEL

type alias Model =
    { topic : String
    , gifUrl : String
    }


init : String -> (Model, Cmd Msg)
init topic =
  ( Model topic "assets/waiting.gif"
  , getRandomGif topic
  )


-- UPDATE

type Msg
    = RequestMore
    | GifFetchSucceed String
    | GifFetchFail Http.Error


update : Msg -> Model -> (Model, Cmd Msg)
update action model =
  case action of
    RequestMore ->
      (model, getRandomGif model.topic)

    GifFetchSucceed url ->
      ( Model model.topic url
      , Cmd.none
      )
    GifFetchFail error ->
      ( model -- for now if the fetch fail we just does nothing
      , Cmd.none
      )


-- VIEW

(=>) = (,)


view : Model -> Html Msg
view model =
  div [ style [ "width" => "200px" ] ]
    [ h2 [headerStyle] [text model.topic]
    , div [imgStyle model.gifUrl] []
    , button [ onClick RequestMore ] [ text "More Please!" ]
    ]


headerStyle : Attribute a
headerStyle =
  style
    [ "width" => "200px"
    , "text-align" => "center"
    ]


imgStyle : String -> Attribute a
imgStyle url =
  style
    [ "display" => "inline-block"
    , "width" => "200px"
    , "height" => "200px"
    , "background-position" => "center center"
    , "background-size" => "cover"
    , "background-image" => ("url('" ++ url ++ "')")
    ]


-- EFFECTS

getRandomGif : String -> Cmd Msg
getRandomGif topic =
  Task.perform GifFetchFail GifFetchSucceed (Http.get decodeUrl (randomUrl topic))



randomUrl : String -> String
randomUrl topic =
  Http.url "http://api.giphy.com/v1/gifs/random"
    [ "api_key" => "dc6zaTOxFJmzC"
    , "tag" => topic
    ]


decodeUrl : Json.Decoder String
decodeUrl =
  Json.at ["data", "image_url"] Json.string
