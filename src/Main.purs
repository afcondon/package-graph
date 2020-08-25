-- Main.purs
module Main where

import Prelude

import Data.Argonaut.Core (Json) as A
import Data.Argonaut.Decode (decodeJson)
import Data.Either (Either(..))
import Data.Foldable (class Foldable)
import Data.Graph as G
import Data.List (List, fromFoldable) as L
import Data.Map (Map, fromFoldable, toUnfoldable) as M
import Data.Set as S
import Data.Tuple (Tuple(..))
import Effect (Effect)
import Effect.Class.Console (log, logShow)

foreign import graphObject :: A.Json
foreign import graphTuples :: A.Json

type PackageName = String
type Path = String -- could level up here with proper platform independent paths 
type RawPackage = { path :: Path, depends :: Array PackageName }
data Package = Package PackageName Path (L.List PackageName)

instance showPackage :: Show Package where
  show (Package name path deps) = name

convert :: M.Map PackageName RawPackage -> L.List Package
convert packageMap = convert' <$> tuples
  where
    tuples :: L.List (Tuple PackageName RawPackage)
    tuples = M.toUnfoldable packageMap
    convert' :: (Tuple PackageName RawPackage) -> Package
    convert' (Tuple k v) = Package k v.path (L.fromFoldable v.depends)

data Dependency = Depend PackageName PackageName

dependencies :: Package -> L.List Dependency
dependencies (Package name _ depends) = (Depend name) <$> depends

-- makeGraph :: L.List Dependency -> Graph
-- makeGraph depends = 

n :: forall k v f. Foldable f => Ord k => Ord v => k -> f v -> Tuple k (Tuple k (S.Set v ))
n k v = Tuple k (Tuple k (S.fromFoldable v ))

--       4 - 8
--      /     \
-- 1 - 2 - 3 - 5 - 7
--          \
--           6
acyclicGraph :: G.Graph Int Int
acyclicGraph =
  G.fromMap (
    M.fromFoldable
      [ n 1 [ 2 ]
      , n 2 [ 3, 4 ]
      , n 3 [ 5, 6 ]
      , n 4 [ 8 ]
      , n 5 [ 7 ]
      , n 6 [ ]
      , n 7 [ ]
      , n 8 [ 5 ]
      ])

--       2 - 4
--      / \
-- 5 - 1 - 3
cyclicGraph :: G.Graph Int Int
cyclicGraph =
  G.fromMap (
    M.fromFoldable
      [ n 1 [ 2 ]
      , n 2 [ 3, 4 ]
      , n 3 [ 1 ]
      , n 4 [ ]
      , n 5 [ 1 ]
      ])


main :: Effect Unit
main = do
  let
    a = (decodeJson graphTuples) :: Either String (M.Map PackageName RawPackage)
    b = case a of
      (Right m) -> convert m
      (Left err) -> mempty
  logShow b
  log "🍝"
