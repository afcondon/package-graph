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


-- someObject = A.fromObject (M.fromFoldable [
--                 Tuple "people" (A.fromArray [
--                   A.jsonSingletonObject "name" (A.fromString "john"),
--                   A.jsonSingletonObject "name" (A.fromString "jane")
--                 ]),
--                 Tuple "common_interests" A.jsonEmptyArray
--               ])

main :: Effect Unit
main = do
  let
    -- a = (decodeJson graphTuples) :: Either String (M.Map String (Array String))
    a = (decodeJson graphArray) :: Either String (Array String)
    -- b = (decodeJson =<< jsonParser jsonString) :: Either String (M.Map String (Array String))
  traceM a
  -- traceM b
  -- traceM $ a == b
