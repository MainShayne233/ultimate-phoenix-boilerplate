defmodule Mix.Tasks.App.Setup.Frontend do
  use Mix.Task

  def run(_args \\ []) do
    Mix.Shell.IO.info "Setting up frontend"
    with {:ok, module} <- get_frontend_module() do
      with :ok <- module.run() do
        remove_other_asset_directories()
      end
    end
  end

  def get_frontend_module do
    frontend_options()
    |> Map.get(config()[:frontend])
    |> case do
      nil ->
        {
          :error,
          """
          No/invalid frontend set in config/setup.ex
          #{valid_options_message()}
          """
        }
      module -> {:ok, module}
    end
  end

  defp frontend_options do
    %{
      "react" => __MODULE__.React,
      "elm" => __MODULE__.Elm,
    }
  end

  defp valid_options_message do
    options = frontend_options()
    |> Map.keys
    |> Enum.map((&("  #{&1}")))
    |> Enum.join("\n")
    """
    Valid frontend options are:
    #{options}
    """
  end

  defp remove_other_asset_directories() do
    Mix.Shell.IO.info "Removing unused asset directories"
    File.ls!
    |> Enum.filter(&(&1 |> String.contains?("assets")))
    |> Enum.reject(&(&1 == "assets"))
    |> Enum.each(fn asset_dir -> 
      Mix.Shell.IO.cmd("rm -rf #{asset_dir}")
    end)
  end

  defdelegate config, to: Mix.Tasks.App.Setup
end
