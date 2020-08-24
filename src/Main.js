// Main.js
var obj = {
  "Data.BooleanAlgebra": ["a", "b"],
  "Data.Ring": ["c", "d"]
};

exports.tuples = Object.entries(obj);

exports.jsonString = JSON.stringify(exports.tuples);
