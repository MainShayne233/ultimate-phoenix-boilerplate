defmodule Mix.Tasks.App.Setup.Frontend.Elm do
  use Mix.Task

  def run(_args \\ []) do
    with :ok <- setup_assets() do
      install_elm_stuff()
    end
  end

  def setup_assets do
    Mix.Shell.IO.info("Using elm_assets")
    Mix.Shell.IO.cmd("mv elm_assets assets")
    :ok
  rescue
    _ -> {:error, "Failed to setup elm assets"}
  end

  def install_elm_stuff do
    Mix.Shell.IO.info("Installing Elm stuff")
    File.cd!("./assets")
    Mix.Shell.IO.cmd("elm package install -y")
    File.cd!("..")
    :ok
  rescue
    _ -> {:error, "Failed to install Elm stuff"}
  end
end
