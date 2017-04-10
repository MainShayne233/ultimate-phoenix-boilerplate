defmodule Mix.Tasks.Rename do
  use Mix.Task

  def current_name, do: "PhoenixReactWebpackBoilerplate"
  def current_otp, do: "phoenix_react_webpack_boilerplate"

  def run(args) do
    with {:ok, {name, otp}} <- get_name(args) do
      rename_in_directory(name, otp)
    end
  end

  def rename_in_directory(name, otp, cwd \\ ".") do
    cwd
    |> File.ls!
    |> Enum.each(fn path ->
      file_or_dir = cwd <> "/" <> path
      cond do
        is_valid_directory?(file_or_dir) ->
          rename_in_directory(name, otp, file_or_dir)
        is_valid_file?(file_or_dir) ->
          with {:ok, file} <- File.read(file_or_dir) do
            updated_file = file
            |> String.replace(current_name(), name)
            |> String.replace(current_otp(), otp)
            File.write(file_or_dir, updated_file)
          end
        true -> :nothing
      end
      file_or_dir
      |> File.rename(String.replace(file_or_dir, current_otp(), otp))
    end)
  end

  def get_name(args) do
    args
    |> case do
      [name, otp] ->
        {:ok, {name, otp}}
      _           ->
        IO.puts """
        Invalid arguments. Command should look like: mix rename AppName app_name
        """
    end
  end

  def is_valid_directory?(dir) do
    File.dir?(dir) and
    dir in bad_directories() == false
  end

  def is_valid_file?(file) do
    File.exists?(file) and
    file in bad_files() == false and
    has_valid_extension?(file)
  end

  def has_valid_extension?(file) do
    extension = file
    |> String.split(".")
    |> List.last
    extension in valid_extensions()
  end

  def valid_extensions do
    [
      "ex",
      "exs",
      "eex",
      "md",
    ]
  end

  def bad_files do
    [
      "./lib/mix/tasks/rename.ex",
    ]
  end

  def bad_directories do
    [
      "./_build",
      "./deps",
      "./assets"
    ]
  end

end
