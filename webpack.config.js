var ExtractTextPlugin = require("extract-text-webpack-plugin");
var path = require("path");
var elmSource = __dirname + "/web/static/elm"

module.exports = function () {
  return {
    entry: ["./web/static/js/app.js", "./web/static/css/app.css"],
    output: {
      path: "./priv/static",
      filename: "js/app.js"
    },
    resolve: {
      extensions: ['.js', '.elm'],
      modules: ["node_modules", __dirname + "/web/static/js"]
    },
    module: {
      rules: [
        {
          test: /\.css$/,
          exclude: /node_modules/,
          loader: ExtractTextPlugin.extract({
            loader: ["css-loader", "postcss-loader"]
          })
        },
        {
          test: /\.js$/,
          exclude: /node_modules/,
          use: [{
            loader: "babel-loader",
            options: {
              presets: ["es2015"]
            },
          }]
        },
        {
          test: /\.elm$/,
          exclude: [/elm-stuff/, /node_modules/],
          loader: "elm-webpack-loader?cwd=" + elmSource
        }
      ]
    },
    devtool: "source-map",
    plugins: [
      new ExtractTextPlugin({
        filename: "css/app.css", 
        disable: false, 
        allChunks: true
      })
    ]
  }
}
