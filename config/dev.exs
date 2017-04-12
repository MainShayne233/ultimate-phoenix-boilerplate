use Mix.Config

config :phoenix_react_webpack_boilerplate, PhoenixReactWebpackBoilerplate.Web.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
   watchers: [
     node: [
       "./node_modules/.bin/webpack-dev-server", "--watch-stdin", "--colors",
       cd: Path.expand("../assets", __DIR__),
     ]
    ]

config :phoenix_react_webpack_boilerplate, PhoenixReactWebpackBoilerplate.Web.Endpoint,
  live_reload: [
    patterns: [
      ~r{priv/gettext/.*(po)$},
      ~r{lib/phoenix_react_webpack_boilerplate/web/views/.*(ex)$},
      ~r{lib/phoenix_react_webpack_boilerplate/web/templates/.*(eex)$}
    ]
  ]

config :logger, :console, format: "[$level] $message\n"

config :phoenix, :stacktrace_depth, 20

config :phoenix_react_webpack_boilerplate, PhoenixReactWebpackBoilerplate.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "phoenix_react_webpack_boilerplate_dev",
  hostname: "localhost",
  pool_size: 10
