{-
Welcome to a Spago project!
You can edit this file as you like.
-}
{ name = "my-project"
, dependencies =
  [ "aff"
  , "argonaut"
  , "catenable-lists"
  , "console"
  , "debug"
  , "effect"
  , "encoding"
  , "graph"
  , "node-fs"
  , "node-fs-aff"
  , "psci-support"
  , "validation"
  , "affjax"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
