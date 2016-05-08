defmodule Peep.Util do
  @doc """
  Get the application directory path for an Ember app
  """
  def app_directory(name) when is_atom(name) do
    {:ok, Path.expand(to_string(name))}
  end

  def app_directory(name) do
    {:ok, Path.expand(name)}
  end

  @doc """
  Run an Ember command.
  """
  @spec ember_command(String.t, list) :: port
  def ember_command(path, args) do
    # Navigate into Ember appliation directory
    cwd = System.cwd!
    File.cd! path

    path_to_ember = Application.get_env :peep, :ember_path,
      "./node_modules/.bin/ember"
    port = Port.open({:spawn_executable, path_to_ember},
      [:use_stdio, :exit_status, :binary, :hide, :stderr_to_stdout, args: args])

    # Reset the current directory to the original value
    File.cd! cwd

    port
  end
end
