defmodule Mix.Tasks.App.Setup.Ecto do
  alias Mix.Tasks.App.Setup
  use Mix.Task

  def run(_name, otp) do
    if Setup.config()[:ecto] == false do
      Mix.Shell.IO.info "Removing Ecto stuff"
      remove_from_configs()
      remove_from_application(otp)
      remove_repo(otp)
      remove_from_errors()
      remove_repo_dir()
      remove_from_tests()
      remove_from_mix_exs()
      remove_deps()
    end
    :ok
  end

  def run(_), do: :nothing

  defp remove_from_configs do
    "config/dev.exs"
    |> Setup.remove_section("Repo", 6)

    "config/test.exs"
    |> Setup.remove_section("Repo", 6)
  end

  defp remove_from_application(otp) do
    "lib/#{otp}/application.ex"
    |> Setup.remove_section("Ecto", 1)
  end

  defp remove_repo(otp) do
    Mix.Shell.IO.cmd("rm -rf lib/#{otp}/repo.ex")
  end

  defp remove_from_errors do
    File.write!("priv/gettext/en/LC_MESSAGES/errors.po", errors_po())
    File.write!("priv/gettext/errors.pot", errors_pot())
  end

  defp remove_repo_dir do
    Mix.Shell.IO.cmd("rm -rf priv/repo")
  end

  def remove_from_tests do
    "test/support/channel_case.ex"
    |> Setup.remove_section("Ecto", 3)
    "test/support/conn_case.ex"
    |> Setup.remove_section("Ecto", 3)
    Mix.Shell.IO.cmd("rm test/support/data_case.ex")
    File.write!("test/test_helper.exs", "ExUnit.start()")
  end

  def remove_from_mix_exs do
    "mix.exs"
    |> Setup.remove_section("aliases")
    "mix.exs"
    |> Setup.remove_section("phoenix_ecto")
    "mix.exs"
    |> Setup.remove_section("postgrex")
    "mix.exs"
    |> Setup.remove_section("defp aliases do", 4)
  end

  def remove_deps do
    Mix.Shell.IO.cmd("rm -rf deps/phoenix_ecto")
    Mix.Shell.IO.cmd("rm -rf deps/postgrex")
  end

  defp errors_po do
    """
    ## `msgid`s in this file come from POT (.pot) files.
    ##
    ## Do not add, change, or remove `msgid`s manually here as
    ## they're tied to the ones in the corresponding POT file
    ## (with the same domain).
    ##
    ## Use `mix gettext.extract --merge` or `mix gettext.merge`
    ## to merge POT files into PO files.
    msgid ""
    msgstr ""
    "Language: en\\n"
    """
  end

  defp errors_pot do
    """
    ## This file is a PO Template file.
    ##
    ## `msgid`s here are often extracted from source code.
    ## Add new translations manually only if they're dynamic
    ## translations that can't be statically extracted.
    ##
    ## Run `mix gettext.extract` to bring this file up to
    ## date. Leave `msgstr`s empty as changing them here as no
    ## effect: edit them in PO (`.po`) files instead.
    
    """
  end
end
