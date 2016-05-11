defmodule Peep.Util do
  require IEx

  def app_directory(name) when is_atom(name) do
    app_directory to_string(name)
  end

  def app_directory(name) do
    project_root = Path.expand(Path.join(Mix.Project.deps_path, ".."))
    path = Path.join(project_root, name)
    {:ok, path}
  end

  @doc """
  Get the absolute path for the Ember application
  """
  @spec ember_app_path :: String.t
  def ember_app_path do
    ember_app = Application.get_env :peep, :ember_app, "ui"
    app_directory ember_app
  end

  @doc """
  Get the absolute path for the Ember build directory
  """
  def ember_dist_dir do
    dist_dir = Application.get_env :peep, :ember_dist_dir, "dist"
    {:ok, path} = ember_app_path
    Path.join(path, dist_dir)
  end

  @doc """
  Run an Ember command.
  """
  @spec ember_command(String.t, list) :: port
  def ember_command(app_path, args) do
    # Navigate into Ember appliation directory
    cwd = System.cwd!
    File.cd! app_path

    path_to_ember = Application.get_env :peep, :ember_path,
      "./node_modules/.bin/ember"
    port = Port.open({:spawn_executable, path_to_ember},
      [:use_stdio, :exit_status, :binary, :hide, :stderr_to_stdout, args: args])

    # Reset the current directory to the original value
    File.cd! cwd

    port
  end
end
