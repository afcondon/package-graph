module Main where

import Prelude

import Data.Argonaut (decodeJson, jsonParser, Json, fromString)
import Data.Argonaut.Decode (decodeJson)
import Data.Either (Either(..))
import Data.Map (Map, fromFoldable) as M
import Effect (Effect)
import Effect.Class.Console (logShow)
import Effect.Console (log)
import Foreign.Object as F
import Node.Encoding (Encoding(..))
import Node.FS.Sync (readTextFile)

decodeAsMap :: String -> Either _ (M.Map String (Array String))
decodeAsMap str = do
    json <- jsonParser str
    obj <- decodeJson json
    pure $ M.fromFoldable $ (F.toUnfoldable obj :: Array _)

  
main :: Effect Unit
main = do
  contents <- readTextFile UTF8 "./graph.json" :: Effect String
  let a = decodeAsMap contents
  case a of
    (Left err) -> log err
    (Right res) -> logShow res
  pure unit
