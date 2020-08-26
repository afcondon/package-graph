# package-graph

Little app to read in the graph output (JSON) from the Purescript compiler and render it in the browser as a graph, using D3.js

*NB* this is scaffolding for something better, there's actually very little to be learnt from what is rendered as of this commit except that all the libraries use one another :-) The point is to get a working example that shows:
  * reading JSON file
  * use of `Object.entries(data)` on the JavaScript side to get something that can have a valid type in PureScript
  * munging of this resulting data into `purescript-graph`
  * transform and throwing it over the FFI for D3

# building and running

it's enough to `spago install`, `spago bundle-app ; mv index.js dist/bundle.js` and then serve the `dist` directory from, for example, `http-serve` and look at it in the browser

# generating `graph.json`

a note to myself as much as anything - ``purs graph `spago sources` > dist/graph.json`` seems to do the trick
