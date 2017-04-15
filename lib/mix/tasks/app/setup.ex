defmodule Mix.Tasks.App.Setup do
  use Mix.Task

  def run([name, otp]) do
    rename_app(name, otp)
    remove_rename_dependency()
    create_prod_secret_config(name, otp)
    git_init()
    node_init()
    remove_mix_task()
    print_conclusion_message()
  end

  def run (_) do
    Mix.Shell.IO.error """
    Must be run with name arguments:
    mix app.setup MyApp my_app
    """
  end

  def rename_app(name, otp) do
    Mix.Shell.IO.info "Renaming app"
    Rename.run(
      {"PhoenixReactWebpackBoilerplate", name},
      {"phoenix_react_webpack_boilerplate", otp}
    )
  end

  defp remove_rename_dependency do
    Mix.Shell.IO.info "Removing rename dependency"
    with_dep_removed = "mix.exs"
    |> File.read!
    |> String.split("\n")
    |> Enum.reject(&(&1 |> String.contains?(":rename")))
    |> Enum.join("\n")
    File.write("mix.exs", with_dep_removed)
  end

  defp create_prod_secret_config(name, otp) do
    Mix.Shell.IO.info "Creating config/prod.secret.exs"
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

  defp git_init do
    if System.get_env("GIT_RESET") == "false" do
      Mix.Shell.IO.info "GIT_RESET set to false. Skipping."
    else
      Mix.Shell.IO.info "Initializing git"
      [
        "rm -rf .git",
        "git init",
        "git add -A",
        "git commit -m 'init'",
      ]
      |> Enum.each(&Mix.Shell.IO.cmd/1)
    end
  end

  defp node_init do
    Mix.Shell.IO.info "Installing npm packages"
    File.cd!("assets")
    Mix.Shell.IO.cmd("npm i")
    File.cd!("..")
  end

  defp remove_mix_task do
    Mix.Shell.IO.info "Removing this mix task (you shouldn't need it anymore)"
    Mix.Shell.IO.cmd("rm -rf lib/mix/tasks/app")
  end

  defp print_conclusion_message do
    Mix.Shell.IO.info """

    Almost done!

    Create your database: 
    mix ecto.create

    Start your app:
    iex -S mix phx.server (or phoenix.server for Phoenix versions < 1.3)

    Visit http://localhost:4000

    Enjoy!
    """
  end
end
