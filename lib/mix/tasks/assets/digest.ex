defmodule Mix.Tasks.Assets.Digest do
  use Mix.Task

  def run(args) do
    Mix.Shell.IO.info "Digesting assets for #{Mix.env}"
    unless File.dir?("./priv/static") do
      Mix.Shell.IO.info("Creating priv/static directory")
      Mix.Shell.IO.cmd("mkdir priv/static")
    end
    [
      "NODE_ENV=production",
      "./assets/node_modules/webpack/bin/webpack.js", "-p",
      "--config", "./assets/webpack.config.js",
    ]
    |> Enum.join(" ")
    |> Mix.Shell.IO.cmd
    :ok = Mix.Tasks.Phx.Digest.run(args)
  end
end
