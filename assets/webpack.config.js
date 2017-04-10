var path = require('path')
var webpack = require('webpack')
var publicPath = 'http://localhost:4002/'

var env = process.env.MIX_ENV || 'dev'
var prod = env === 'prod'

var ExtractTextPlugin = require("extract-text-webpack-plugin");
var CopyWebpackPlugin = require("copy-webpack-plugin");

var entry = {
  'priv/static/js/app.bundle': './assets/js/main.js',
  'priv/static/css/app.bundle': './assets/css/app.less'
}

var hotEntry = './assets/js/main.js'

var hot = 'webpack-hot-middleware/client?path=' +
  publicPath + '__webpack_hmr&noInfo=true'


var plugins = [
  new ExtractTextPlugin('[name].css'),
  new webpack.optimize.OccurrenceOrderPlugin(),
  new webpack.NoEmitOnErrorsPlugin(),
  new webpack.DefinePlugin({
    __PROD: prod,
    __DEV: env === 'dev'
  })
]

if (env === 'dev') {
  plugins.push(new webpack.HotModuleReplacementPlugin())
}

module.exports = {
  devtool: prod ? false : 'cheap-module-eval-source-map',
  entry: prod ? entry : [hot, hotEntry],
  output: {
    path: path.resolve(__dirname) + '/',
    filename: prod ? '[name].js' : 'app.bundle.js',
    publicPath: publicPath
  },
  resolve: {
    modules: [ "assets/node_modules", __dirname + "/assets/js" ],
    extensions: ['*', '.js', '.jsx'],
  },
  resolveLoader: { 
    modules: [path.join(__dirname, "node_modules")] 
  },
  plugins: plugins,
  module: {
    loaders: [
      {
        test: /\.jsx?$/,
        loaders: ['babel-loader'],
        exclude: path.resolve(__dirname, 'assets/node_modules'),
        include: __dirname,
      },
      {
        test: /\.css$/,
        loader: ExtractTextPlugin.extract({fallback: "style-loader", use: "css-loader"}),
      },
      {
        test: /\.less$/,
        loader: ExtractTextPlugin.extract({fallback: "style-loader", use: "css-loader!less-loader"}),
      },
      {
        test: /\.scss$/,
        loader: ExtractTextPlugin.extract({fallback: "style-loader", use: "css-loader!sass-loader"}),
      },
      {
        test: /\.svg/,
        loader: 'svg-url-loader',
      },
      {
        test: /\.woff2?(\?v=[0-9]\.[0-9]\.[0-9])?$/,
        loader: "url-loader?limit=10000&mimetype=application/font-woff&name=priv/static/woff2/[name].woff2",
      },
      {
        test: /\.woff?(\?v=[0-9]\.[0-9]\.[0-9])?$/,
        loader: "url-loader?limit=10000&mimetype=application/font-woff&name=priv/static/woff/[name].woff",
      },
      {
        test: /\.eot(\?v=\d+\.\d+\.\d+)?$/,
        loader: "url-loader?name=priv/static/eot/[name].eot",
      },
      {
        test: /\.ttf(\?v=\d+\.\d+\.\d+)?$/,
        loader: "url-loader?limit=10000&mimetype=application/octet-stream&name=priv/static/ttf/[name].ttf",
      },
      {
        test: /\.(png|jpg)$/,
        loader: 'url-loader?prefix=assets/'
      },
    ]
  }
}
