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

-- | Orphan instance not allowed but this is what's needed in the base library
-- instance showGraph :: Show G.Graph where
--   show graph = show $ G.toMap graph

-- | generic constructor for graph node
n :: forall k v f. Foldable f => Ord k => Ord v => k -> f v -> Tuple k (Tuple k (S.Set v ))
n k v = Tuple k (Tuple k (S.fromFoldable v ))

-- | specialized constructor from Package ADT
n' :: Package -> Tuple PackageName (Tuple PackageName (S.Set PackageName))
n' (Package name _ depends) = Tuple name (Tuple name (S.fromFoldable depends ))


main :: Effect Unit
main = do
  let
    packageMap = (decodeJson graphTuples) :: Either String (M.Map PackageName RawPackage)
    packageGraph = 
      case packageMap of
        (Right m) -> G.fromMap $ M.fromFoldable $ n' <$> convert m
        (Left err) -> G.empty
  log $ show $ G.toMap packageGraph
  log "🍝"
