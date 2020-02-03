// Main.js

var obj2 = {
  "Data.BooleanAlgebra": {
      "path": ".spago/prelude/v4.1.1/src/Data/BooleanAlgebra.purs",
      "depends": [
          "Data.HeytingAlgebra",
          "Data.Symbol",
          "Data.Unit",
          "Data.Show",
          "Record.Unsafe",
          "Type.Data.RowList",
          "Type.Data.Row"
      ]
  },
  "Data.Ring": {
      "path": ".spago/prelude/v4.1.1/src/Data/Ring.purs",
      "depends": [
          "Data.Semiring",
          "Data.Symbol",
          "Data.Unit",
          "Data.Show",
          "Record.Unsafe",
          "Type.Data.RowList",
          "Type.Data.Row"
      ]
  }
}

exports.tuples = Object.entries(obj2);
