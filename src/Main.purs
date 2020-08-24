-- Main.purs
module Main where

import Prelude

import Data.Argonaut.Core (Json, fromArray, fromObject, fromString, jsonEmptyArray, jsonSingletonObject) as A
import Data.Argonaut.Decode (decodeJson)
import Data.Argonaut.Parser (jsonParser)
import Data.Either (Either)
import Data.Map (Map, fromFoldable) as M
import Data.Tuple (Tuple(..))
import Debug.Trace (traceM)
import Effect (Effect)

foreign import graphObject :: A.Json
foreign import graphTuples :: A.Json
foreign import graphArray :: A.Json
-- foreign import jsonString :: String
-- foreign import someObjectFn :: A.Json



-- data Package = { path :: String, depends :: Array String }

main :: Effect Unit
main = do
  let
    a = (decodeJson graphTuples) :: Either String (M.Map String A.Json)
    -- b = (decodeJson =<< jsonParser jsonString) :: Either String (M.Map String (Array String))
  traceM a
  -- traceM b
  -- traceM $ a == b
