# package-graph

Little app to read in the graph output (JSON) from the Purescript compiler and render it in the browser as a graph, using D3.js

# building and running

it's enough to `spago install`, `spago bundle-app ; mv index.js dist/bundle.js` and then serve the `dist` directory from, for example, `http-serve` and look at it in the browser

# generating `graph.json`

a note to myself as much as anything - `purs graph \`spago sources\` > dist/graph.json` seems to do the trick
