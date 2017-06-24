use Mix.Config

# Sample config for React frontend

config :ultimate_phoenix_boilerplate, Mix.Tasks.App.Setup,
  name:     "NewApp",
  otp:      "new_app",
  ecto:     true,
  frontend: "react"

# Sample config for Elm frontend

# config :ultimate_phoenix_boilerplate, Mix.Tasks.App.Setup,
#   name:     "NewApp",
#   otp:      "new_app",
#   frontend: "elm"
