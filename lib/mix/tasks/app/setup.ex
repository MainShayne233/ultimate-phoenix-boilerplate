defmodule Mix.Tasks.App.Setup do
  use Mix.Task

  def run([name, otp]) do
    git_init()
    Mix.Tasks.Deps.Get.run([])
    Mix.Tasks.App.Rename.run([name, otp])
    Mix.Tasks.Ecto.Create.run([])
    node_init()
  end

  def run (_) do
    IO.puts """
    Must be run with name arguments:
    mix app.setup MyApp my_app
    """
  end

  def git_init do
    [
      "rm -rf .git",
      "git init",
      "git add -A",
      "git commit -m 'init'",
    ]
    |> Enum.each(&Mix.Shell.IO.cmd/1)
  end

  def node_init do
    File.cd!("assets")
    Mix.Shell.IO.cmd("npm i")
    File.cd!("..")
  end

end
