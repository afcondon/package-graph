-- Main.purs
module Main where

import Data.Graph
import Prelude

import Control.Monad.List.Trans (singleton)
import Data.Argonaut.Core (Json, fromArray, fromObject, fromString, jsonEmptyArray, jsonSingletonObject) as A
import Data.Argonaut.Decode (decodeJson)
import Data.Argonaut.Parser (jsonParser)
import Data.Array as Array
import Data.Either (Either(..))
import Data.Map (Map, fromFoldable, keys, lookup) as M
import Data.Tuple (Tuple(..))
import Effect (Effect)
import Effect.Class.Console (log)

foreign import graphObject :: A.Json
foreign import graphTuples :: A.Json

type PackageName = String
type Path = String -- could level up here with proper platform independent paths 
type Package = { path :: Path, depends :: Array PackageName }

type PathsMap = M.Map PackageName Path
type Dependencies = M.Map PackageName (Array PackageName)

dependencies :: Package -> Array PackageName
dependencies { depends } = depends

dependenciesMap :: M.Map PackageName Package -> M.Map PackageName (Array PackageName)
dependenciesMap = map dependencies

-- makeGraph :: Array (Tuple String Package) -> Array String
-- makeGraph tuples = 


main :: Effect Unit
main = do
  let
    a = (decodeJson graphTuples) :: Either String (M.Map PackageName Package)
    b = case a of
      (Right m) -> dependenciesMap m
      (Left err) -> mempty
  log "🍝"
