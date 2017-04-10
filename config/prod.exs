use Mix.Config

config :phoenix_react_webpack_boilerplate, PhoenixReactWebpackBoilerplate.Web.Endpoint,
  on_init: {PhoenixReactWebpackBoilerplate.Web.Endpoint, :load_from_system_env, []},
  url: [host: "example.com", port: 80],
  cache_static_manifest: "priv/static/cache_manifest.json"

config :logger, level: :info


import_config "prod.secret.exs"
