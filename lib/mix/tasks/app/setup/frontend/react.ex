defmodule Mix.Tasks.App.Setup.Frontend.React do
  use Mix.Task

  def run(_args \\ []) do
    setup_assets()
  end

  def setup_assets do
    Mix.Shell.IO.info("Using react_assets")
    Mix.Shell.IO.cmd("mv react_assets assets")
    :ok
  rescue
    _ -> {:error, "Failed to setup react assets"}
  end
end
