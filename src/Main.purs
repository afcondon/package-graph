-- Main.purs
module Main where

import Prelude

import Affjax (Error, get, printError)
import Affjax.ResponseFormat as ResponseFormat
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
import Effect.Aff (launchAff_)
import Effect.Class (class MonadEffect)
import Effect.Class.Console (log)

-- import Node.FS.Aff (readTextFile)

foreign import fileToTuples :: String -> A.Json

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

-- | generic constructor for graph node
n :: forall k v f. Foldable f => Ord k => Ord v => k -> f v -> Tuple k (Tuple k (S.Set v ))
n k v = Tuple k (Tuple k (S.fromFoldable v ))

-- | specialized constructor from Package ADT
n' :: Package -> Tuple PackageName (Tuple PackageName (S.Set PackageName))
n' (Package name _ depends) = Tuple name (Tuple name (S.fromFoldable depends ))

extractBody :: forall r. Either Error { body ∷ String | r } -> Either String String
extractBody (Right { body } ) = Right body
extractBody (Left err)        = Left $ printError err

makePackageMap :: Either String String -> Either String (M.Map String RawPackage)
makePackageMap (Right body) = (decodeJson $ fileToTuples body) :: Either String (M.Map PackageName RawPackage)
makePackageMap (Left err)   = (Left err)

makePackageGraph :: M.Map String RawPackage -> G.Graph String String
makePackageGraph packageMap =
  let converted = n' <$> convert packageMap
      graph = G.fromMap $ M.fromFoldable $ converted
  in graph

makeShowGraph :: G.Graph String String -> String
makeShowGraph graph = show $ G.toMap graph

allInOne :: Either String String -> Either String String
allInOne body = do
  pmap <- makePackageMap body
  let pgraph = makePackageGraph pmap
  pure $ makeShowGraph pgraph

showGraph :: forall m. MonadEffect m => Either String String -> m Unit
showGraph (Right graph) = log graph
showGraph (Left err)    = log err

-- fromBodyToString :: forall r. Either Error { body :: String | r } 
main :: Effect Unit
main = launchAff_ do -- Aff 
  result <- get ResponseFormat.string "http://localhost:1234/graph.json"
  let body = extractBody result
      stringRep = allInOne body
  showGraph stringRep
  log "🍝"
