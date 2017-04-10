defmodule Mix.Tasks.Assets.Digest do
  use Mix.Task

  def run(args) do
    IO.puts "Digesting assets for #{Mix.env}"
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
