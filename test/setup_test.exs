defmodule SetupTest do
  use ExUnit.Case, async: false

  @app_dir "ultimate_phoenix_boilerplate_test_app"
  @app_name "UltimatePhoenixBoilerplateTestApp"
  @git_repo "https://www.github.com/MainShayne233/ultimate-phoenix-boilerplate.git "

  @tag timeout: :infinity
  test "should be able to setup app with default config with no issue" do
    File.cd!("..")
    :os.cmd('rm -rf #{@app_dir}')
    git_clone_boilerplate()
    File.cd!(@app_dir)
    :os.cmd('mix deps.get')
    :os.cmd('mix app.setup #{@app_name} #{@app_dir}')
    start_server()
    :timer.sleep(10000)
    {page, 0} = System.cmd("curl", ["localhost:4000"])
    assert page |> String.contains?("Hello UltimatePhoenixBoilerplateTestApp!")
    kill_server()
  end

  defp git_clone_boilerplate do
    :os.cmd('git clone #{@git_repo} #{@app_dir}')
  end

  defp start_server do
    spawn fn ->
      :os.cmd('mix phoenix.server')
    end
  end

  defp kill_server do
    "ps"
    |> System.cmd(["-ef"])
    |> elem(0)
    |> String.split("\n")
    |> Enum.filter(&( &1 |> String.contains?("mix phoenix.server") ))
    |> Enum.each(fn process -> 
      pid = process
      |> String.split(" ")
      |> Enum.reject(&( &1 == "" ))
      |> Enum.at(1)
      :os.cmd('kill -9 #{pid}')
    end)
  end
end
