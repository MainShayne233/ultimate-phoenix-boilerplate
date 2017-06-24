# Ultimate Phoenix Boilerplate
Phoenix + (your favorite frontend framework) made easy.

[![Build Status](https://travis-ci.org/MainShayne233/ultimate-phoenix-boilerplate.svg?branch=master)](https://travis-ci.org/MainShayne233/ultimate-phoenix-boilerplate)

This boilerplate aims to make it easy to start using a frontend framework with
Phoenix, and leaving you with no leftover boilerplate clutter.

Note: This boilerplate is based on Phoenix 1.3, which uses `phx` instead of `phoenix` for things like mix tasks (`mix phx.server`, for example).
Using `phoenix` should still work, but I advice you
to [install Phoenix 1.3](https://github.com/phoenixframework/phoenix/blob/master/installer/README.md)

## Support

### Frontends
- React
- Elm

### Stylesheets
- SASS (.scss)

## Make it your own

### Choose your configuration

If you want the default configuration:
- React
- Webpack (with hot reloading)
- SASS (.scss)

then skip to running the setup commands.

If you want something different you can change the setup configuration in `config/setup.exs`.

A config for using Elm would look like:
```elixir
config :ultimate_phoenix_boilerplate, Mix.Tasks.App.Setup,
  name:     "NewApp",  # the name for your app
  otp:      "new_app", # typically your app's name in snake case
  ecto:     true,      # want to use ecto/postgres? default true
  frontend: "elm"      # check supported frontends for options
```

Then run the setup commands.

### Setup commands
```bash
# clone repo with your app name
git clone https://github.com/MainShayne233/ultimate-phoenix-boilerplate.git your_app_name
# enter project directory
cd your_app_name
# fetch dependencies
mix deps.get
# run handy dandy mix task
mix app.setup YourAppName your_app_name # optional name arguments override those in config/setup.exs
# create your database
mix ecto.create
# start the server
iex -S mix phx.server
```

Then visit [localhost:4000](http://localhost:4000)

## Compiling assets
This boilerplate serves up assets via the Webpack server middleware. However,
compiling assets is as easy as
```bash
mix assets.digest

# and for prod

MIX_ENV=prod mix assets.digest
```

## Silence the webpack log
The webpack log can be useful when debugging things like a stylesheet synatx error, but it can
be annoying when all you care about is the Elixir console. To silence the webpack server, add ```quiet: true``` to the ```devServer``` config in ```./assets/webpack.config.js```
```javascript
  devServer: {
    hot: true,
    overlay: true,
    quiet: true,
    port: 4002,
    historyApiFallback: true,
    headers: {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, PATCH, OPTIONS',
      'Access-Control-Allow-Headers': 'X-Requested-With, content-type, Authorization',
    },
  },
``````
## Roadmap

### Frontends
- Ember
- Angular
### Configuration
- React
  - react-router
  - redux
### Stylesheets
- LESS
- PostCSS
