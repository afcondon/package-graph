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
  , "node-fs"
  , "node-fs-aff"
  , "psci-support"
  , "validation"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
