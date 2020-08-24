-- Main.purs
module Main where

import Prelude

import Data.Argonaut.Core (Json)
import Data.Argonaut.Decode (decodeJson)
import Data.Argonaut.Parser (jsonParser)
import Data.Either (Either)
import Data.Map (Map)
import Debug.Trace (traceM)
import Effect (Effect)

foreign import tuples :: Json
foreign import jsonString :: String

main :: Effect Unit
main = do
  let
    a = (decodeJson tuples) :: Either String (Map String (Array String))
    b = (decodeJson =<< jsonParser jsonString) :: Either String (Map String (Array String))
  traceM a
  traceM b
  traceM $ a == b
