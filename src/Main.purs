module Main where

import Prelude

import Data.Argonaut.Core (Json, fromString)
import Data.Argonaut.Decode (decodeJson)
import Data.Either (Either(..))
import Data.List (List)
import Data.Map (Map)
import Effect (Effect)
import Effect.Class.Console (logShow)
import Effect.Console (log)
import Node.Encoding (Encoding(..))
import Node.FS.Sync (readTextFile)


type Module = { path :: String, depends :: List String }

moduleFromJson :: Json -> Either String Module
moduleFromJson = decodeJson

main :: Effect Unit
main = do
  contents <- readTextFile UTF8 "./graph.json" :: Effect String
  logShow contents
  -- let a = (decodeJson $ fromString contents) :: Either String (Map String Module)
  -- case a of
  --   (Left err) -> log err
  --   (Right res) -> logShow res
  pure unit
