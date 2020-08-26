// Main.js

// var d3 = require('d3')

exports.fileToTuplesFFI = function (file) {
  var json = JSON.parse(file)
  return Object.entries(json)
}

exports.showGraphFFI = function(graph) {
  d3.selectAll('div#app')
    .append('svg')
  console.log("imagine there was a graph here");
}
