// Main.js

var lineSelection
var circleSelection

exports.fileToTuplesFFI = function (file) {
  var json = JSON.parse(file)
  return Object.entries(json)
}

exports.showGraphFFI = function(width, height, graph) {
// initialize the DOM and make initial selections
  var svg = d3.selectAll('div#app')
              .append('svg')
              .attr('id', 'forceSVG')
              .attr('width', width)
              .attr('height', height)
              .append('g')
              .attr('class', 'forceGroup')
  lineSelection = svg.append('g').attr('class', 'forcelinks').selectAll('line')
  circleSelection = svg.append('g').attr('class', 'forcenodes').selectAll('circle')
// initialize the simulation
  var simulation = 
    d3.forceSimulation()
      .alpha(1) // default is 1
      .alphaTarget(0) // default is 0
      .alphaMin(0.00001) // default is 0.0001
      .alphaDecay(0.0228) // default is 0.0228
      .velocityDecay(0.4) // default is 0.4
  
// now the data join
  lineSelection = lineSelection
    .data(graph.links, d => d.id)
    .join(enter => enter.append('line').attr('stroke', 'gray').attr('stroke-width', 0.2))
  circleSelection = circleSelection 
    .data(graph.nodes, d => d.id)
    .join(enter => 
        enter.append('circle')
             .attr('r', 5)
             .attr('class', 'force')
             .attr('fill', 'gray')
             .attr('stroke', 'blue') )
// mark all nodes as (x,y) == NaN, so that D3 will position them
  // provokePhylotaxis(graph)
// kick off an intial simulation
  simulation.nodes(graph.nodes)
            .force("charge", d3.forceManyBody().strength(-100))
            .force('collision', d3.forceCollide(30))
            .force('center', d3.forceCenter(400,400))
            .force('link', d3.forceLink().id(d => d.id).links(graph.links).strength(1))
            .on('tick', normalTick)
  
}

var normalTick = function () {
  circleSelection
    .attr('cx', d => d.x)
    .attr('cy', d => d.y)
  
  lineSelection
    .attr('x1', d => d.source.x)
    .attr('y1', d => d.source.y)
    .attr('x2', d => d.target.x)
    .attr('y2', d => d.target.y)
}


var provokePhylotaxis = function(graph) {
  graph.nodes.forEach(node => {
    node.x = NaN
    node.y = NaN
  })
}

var clusterAsCircles = function(sim, collisionFactor) {
  var rect = getRootRect()
  sim.nodes(model.forceNodesD3)
     .force('collision', d3.forceCollide(collisionFactor))
     .force('center', d3.forceCenter(rect.w/2, rect.h/2))
     .on('tick', normalTick)
}
