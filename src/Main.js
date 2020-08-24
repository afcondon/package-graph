// Main.js
var obj = {
  'Data.BooleanAlgebra': ['a', 'b'],
  'Data.Ring': ['c', 'd']
}

var graph = {
  'Data.BooleanAlgebra': {
    path: '.spago/prelude/v4.1.1/src/Data/BooleanAlgebra.purs',
    depends: [
      'Data.HeytingAlgebra',
      'Data.Symbol',
      'Data.Unit',
      'Data.Show',
      'Record.Unsafe',
      'Type.Data.RowList',
      'Type.Data.Row'
    ]
  },
  'Data.Ring': {
    path: '.spago/prelude/v4.1.1/src/Data/Ring.purs',
    depends: [
      'Data.Semiring',
      'Data.Symbol',
      'Data.Unit',
      'Data.Show',
      'Record.Unsafe',
      'Type.Data.RowList',
      'Type.Data.Row'
    ]
  }
}

exports.someObject = {
  people: [{ name: 'john' }, { name: 'jane' }],
  common_interests: []
}

var toplevel = Object.entries(obj)
var inner = toplevel.forEach(element => {
  Object.entries(element) // should get us path / depends
})

exports.tuples = Object.entries(obj)

exports.jsonString = JSON.stringify(exports.tuples)
