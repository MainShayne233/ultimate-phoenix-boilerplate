const webpack = require('webpack')
const CopyWebpackPlugin = require('copy-webpack-plugin')
const ExtractTextPlugin = require("extract-text-webpack-plugin")
const WriteFilePlugin = require('write-file-webpack-plugin')
const path = require('path')
const env = process.env.MIX_ENV || 'dev'
const prod = env === 'prod'

const prodPlugins = [
  new webpack.optimize.OccurrenceOrderPlugin(),
  new webpack.NoEmitOnErrorsPlugin(),
  new webpack.DefinePlugin({
    __PROD: prod,
    __DEV: env === 'dev'
  }),
  new CopyWebpackPlugin([{from: "./assets"}]),
  new ExtractTextPlugin("css/styles.css"),
  new WriteFilePlugin(),
]

const devPlugins = [
  new CopyWebpackPlugin([{
    from: path.join(__dirname, 'static'),
    to: path.join(__dirname, '..', 'priv', 'static'),
  }]),
  new webpack.optimize.OccurrenceOrderPlugin(),
  new webpack.NoEmitOnErrorsPlugin(),
  new webpack.HotModuleReplacementPlugin(),
  new WriteFilePlugin(),
  new webpack.DefinePlugin({
    __PROD: prod,
    __DEV: env === 'dev',
  }),
]

const publicPath = "http://localhost:4002/"

const entry = path.join(__dirname, 'js', 'main.js')
const hot = 'webpack-dev-server/client?http://localhost:4002'

const config = {
  devtool: prod ? false : 'cheap-module-eval-source-map',
  entry: prod ? entry : [hot, entry],
  output: {
    path: path.join(__dirname, '..', 'priv', 'static', 'js'),
    filename: 'app.bundle.js',
    publicPath: publicPath, 
  },
  devServer: {
    hot: true,
    inline: true,
    overlay: true,
    port: 4002,
    historyApiFallback: true,
    headers: {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, PATCH, OPTIONS',
      'Access-Control-Allow-Headers': 'X-Requested-With, content-type, Authorization',
    },
  },
  resolve: {
    modules: [
      __dirname,
      'node_modules',
      'js',
      'elm',
    ],
    extensions: ['*', '.js', '.elm'],
    alias: {
      phoenix: path.join(__dirname, '..', 'deps', 'phoenix', 'priv', 'static', 'phoenix.js'),
    },
  },
  resolveLoader: {
    modules: [path.join(__dirname, 'node_modules')],
  },
  module: {
    rules: [
      {
        test: /\.scss$/,
        use: [
          'style-loader',
          'css-loader',
          'sass-loader',
        ],
      },
      {

        test: /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/],
        use: [
          'elm-hot-loader',
          `elm-webpack-loader?pathToMake=./node_modules/.bin/elm-make${prod ? '&cwd=assets' : ''}&verbose=true&warn=false`,
        ],
      },
    ],
  },
  plugins: prod ? prodPlugins : devPlugins,
}


module.exports = config
