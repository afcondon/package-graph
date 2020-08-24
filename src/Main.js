// Main.js

exports.graphObject = {
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

function propertiesToArray(obj) {
  const isObject = val =>
      typeof val === 'object' && !Array.isArray(val);

  const addDelimiter = (a, b) =>
      a ? `${a}.${b}` : b;

  const paths = (obj = {}, head = '') => {
      return Object.entries(obj)
          .reduce((product, [key, value]) => 
              {
                  let fullPath = addDelimiter(head, key)
                  return isObject(value) ?
                      product.concat(paths(value, fullPath))
                  : product.concat(fullPath)
              }, []);
  }

  return paths(obj);
}

// graphTuples :: A.Json
// the json that is returned is expected to be of the form M.Map String (Array String)
exports.graphTuples = Object.entries(exports.graphObject)
exports.graphArray = propertiesToArray(exports.graphObject)

exports.jsonString = JSON.stringify(exports.tuples)
