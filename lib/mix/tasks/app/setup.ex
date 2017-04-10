defmodule Mix.Tasks.App.Setup do
  use Mix.Task

  def run([name, otp]) do
    IO.puts "Initializing git"
    git_init()
    IO.puts "Fetching dependencies"
    Mix.Tasks.App.Rename.run([name, otp])
    IO.puts "Creating database"
    Mix.Tasks.Ecto.Create.run(["-r", "#{name}.Repo"])
    IO.puts "Installing npm packages"
    node_init()
    IO.puts """
    All done!
    Run iex -S mix phx.server (or phoenix.server for Phoenix versions < 1.3)
    Visit http://localhost:4000
    Enjoy!
    """
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
