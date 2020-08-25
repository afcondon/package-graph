// Main.js


exports.fileToTuples = function (file) {
  var json = JSON.parse(file)
  return Object.entries(json)
}