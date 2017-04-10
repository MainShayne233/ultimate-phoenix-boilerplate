var path = require('path')
var webpack = require('webpack')
var publicPath = 'http://localhost:4002/'

var env = process.env.MIX_ENV || 'dev'
var prod = env === 'prod'

var entry = './assets/js/main.js'

var hot = 'webpack-hot-middleware/client?path=' +
  publicPath + '__webpack_hmr&noInfo=true'

var plugins = [
  new webpack.optimize.OccurrenceOrderPlugin(),
  new webpack.NoEmitOnErrorsPlugin(),
  new webpack.DefinePlugin({
    __PROD: prod,
    __DEV: env === 'dev'
  })
]

if (!prod) plugins.push(new webpack.HotModuleReplacementPlugin())

module.exports = {
  devtool: prod ? false : 'cheap-module-eval-source-map',
  entry: prod ? entry : [hot, entry],
  output: {
    path: path.resolve('priv/static/js'),
    filename: 'app.bundle.js',
    publicPath: publicPath,
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
    rules: [
      {
        test: /\.less$/,
        use: [
          "style-loader",
          "css-loader",
          "less-loader",
        ]
      },
      {
        test: /\.jsx?$/,
        exclude: path.resolve(__dirname, 'assets/node_modules'),
        include: __dirname,
        use: [
          'babel-loader'
        ]
      },
    ]
  }
}
