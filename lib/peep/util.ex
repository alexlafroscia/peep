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
end
