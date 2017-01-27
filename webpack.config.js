var ExtractTextPlugin = require('extract-text-webpack-plugin');
var path = require('path');

module.exports = function () {
  return {
    entry: ["./web/static/js/app.js", "./web/static/css/app.css"],
    output: {
      path: "./priv/static",
      filename: "js/app.js"
    },
    resolve: {
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
            loader: 'babel-loader',
            options: {
              presets: ['es2015']
            },
          }]
        }
      ]
    },
    devtool: 'source-map',
    plugins: [
      new ExtractTextPlugin({
        filename: "css/app.css", 
        disable: false, 
        allChunks: true
      })
    ]
  }
}
