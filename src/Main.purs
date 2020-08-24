-- Main.purs
module Main where

import Prelude

import Data.Argonaut.Core (Json, fromArray, fromObject, fromString, jsonEmptyArray, jsonSingletonObject) as A
import Data.Argonaut.Decode (decodeJson)
import Data.Argonaut.Parser (jsonParser)
import Data.Array as Array
import Data.Either (Either(..))
import Data.Map (Map, fromFoldable, keys, lookup) as M
import Data.Tuple (Tuple(..))
import Debug.Trace (traceM)
import Effect (Effect)

foreign import graphObject :: A.Json
foreign import graphTuples :: A.Json




type Package = { path :: String, depends :: Array String }

main :: Effect Unit
main = do
  let
    a = (decodeJson graphTuples) :: Either String (M.Map String Package)
    b = case a of
      (Right m) -> Array.fromFoldable $ M.keys m
      (Left err) -> ["didn't work"]
  traceM a
  traceM b
