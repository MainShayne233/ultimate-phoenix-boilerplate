defmodule Mix.Tasks.App.Setup.Frontend.Elm do
  use Mix.Task

  def run(_args \\ []) do
    setup_assets()
  end

  def setup_assets do
    Mix.Shell.IO.info("Using elm_assets")
    Mix.Shell.IO.cmd("mv elm_assets assets")
    :ok
  rescue
    _ -> {:error, "Failed to setup elm assets"}
  end
end
