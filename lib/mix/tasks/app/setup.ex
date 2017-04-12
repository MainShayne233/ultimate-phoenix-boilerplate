defmodule Mix.Tasks.App.Setup do
  use Mix.Task

  def run([name, otp]) do
    Mix.Tasks.App.Rename.run([name, otp])
    IO.puts "Creating config/prod.secret.exs"
    create_prod_secret_config(name, otp)
    IO.puts "Initializing git"
    git_init()
    IO.puts "Installing npm packages"
    node_init()
    IO.puts """

    Almost done!

    Create your database: 
    mix ecto.create

    Start your app:
    iex -S mix phx.server (or phoenix.server for Phoenix versions < 1.3)

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

  defp git_init do
    [
      "rm -rf .git",
      "git init",
      "git add -A",
      "git commit -m 'init'",
    ]
    |> Enum.each(&Mix.Shell.IO.cmd/1)
  end

  defp node_init do
    File.cd!("assets")
    Mix.Shell.IO.cmd("npm i")
    File.cd!("..")
  end

  defp create_prod_secret_config(name, otp) do
    file = """
    use Mix.Config

    config :#{otp}, #{name}.Web.Endpoint,
      secret_key_base: "#{new_secret()}"
    
    config :#{otp}, #{name}.Repo,
      adapter: Ecto.Adapters.Postgres,
      username: "postgres",
      password: "postgres",
      database: "#{otp}_prod",
      pool_size: 15
    """
    File.write("./config/prod.secret.exs", file)
  end

  defp new_secret do
    64
    |> :crypto.strong_rand_bytes
    |> Base.encode64 
    |> binary_part(0, 64)
  end

end
