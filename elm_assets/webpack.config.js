var webpack = require('webpack')
var CopyWebpackPlugin = require('copy-webpack-plugin');
var ExtractTextPlugin = require("extract-text-webpack-plugin");
var path = require('path');
var env = process.env.MIX_ENV || 'dev';
var prod = env === 'prod';

var prodPlugins = [
  new webpack.optimize.OccurrenceOrderPlugin(),
  new webpack.NoErrorsPlugin(),
  new webpack.DefinePlugin({
    __PROD: prod,
    __DEV: env === 'dev'
  }),
  new CopyWebpackPlugin([{from: "./assets"}]),
  new ExtractTextPlugin("css/styles.css")
];



var devPlugins = [
  new CopyWebpackPlugin([{ from: path.join(__dirname,'static') }]),
  new webpack.optimize.OccurrenceOrderPlugin(),
  new webpack.NoEmitOnErrorsPlugin(),
  new webpack.HotModuleReplacementPlugin(),
  new webpack.DefinePlugin({
    __PROD: prod,
    __DEV: env === 'dev',
  }),
]



var devPublicPath = "http://localhost:4002/";
var prodPublicPath = null;

var entry = "./js/main.js";
var hot = 'webpack-dev-server/client?http://localhost:4002';

var config = {
  devtool: prod ? null : 'cheap-module-eval-source-map',
  entry: prod ? entry : [hot, entry],
  output: {
    path: path.resolve(__dirname) + '/priv/static',
    filename: 'app.bundle.js',
    publicPath: prod ? prodPublicPath : devPublicPath
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
          'elm-webpack-loader?verbose=true&warn=false',
        ],
        //include: path.join(__dirname, 'js'),
      },
    ],
  },
  plugins: prod ? prodPlugins : devPlugins,
};


module.exports = config;
