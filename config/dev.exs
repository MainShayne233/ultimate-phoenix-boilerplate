use Mix.Config

config :ultimate_phoenix_boilerplate, UltimatePhoenixBoilerplate.Web.Endpoint,
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

config :ultimate_phoenix_boilerplate, UltimatePhoenixBoilerplate.Web.Endpoint,
  live_reload: [
    patterns: [
      ~r{priv/gettext/.*(po)$},
      ~r{lib/ultimate_phoenix_boilerplate/web/views/.*(ex)$},
      ~r{lib/ultimate_phoenix_boilerplate/web/templates/.*(eex)$}
    ]
  ]

config :logger, :console, format: "[$level] $message\n"

config :phoenix, :stacktrace_depth, 20

config :ultimate_phoenix_boilerplate, UltimatePhoenixBoilerplate.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "ultimate_phoenix_boilerplate_dev",
  hostname: "localhost",
  pool_size: 10


  
import_config "setup.exs"
