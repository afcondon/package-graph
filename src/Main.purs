module Main where

import Prelude

import Data.Argonaut.Core (Json)
import Data.Argonaut.Decode (decodeJson)
import Data.Argonaut.Parser (jsonParser)
import Data.Either (Either)
import Data.Map (Map)
import Debug.Trace (traceM)
import Effect (Effect)
import Effect.Console (log)

foreign import tuples :: Json

type Module = { path :: String, depends :: Array String }

moduleFromJson :: Json -> Either String Module
moduleFromJson = decodeJson


main :: Effect Unit
main = do
  let
    a = (decodeJson tuples) :: Either String (Map String Module)

  traceM a
