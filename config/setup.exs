use Mix.Config

# Sample config for React frontend

config :ultimate_phoenix_boilerplate, Mix.Tasks.App.Setup,
  ecto:     true, # set to false if you don't want to use ecto/postgres
  name:     "NewApp",
  otp:      "new_app",
  frontend: "react"

# Sample config for Elm frontend

# config :ultimate_phoenix_boilerplate, Mix.Tasks.App.Setup,
#   name:     "NewApp",
#   otp:      "new_app",
#   frontend: "elm"
