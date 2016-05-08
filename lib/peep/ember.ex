defmodule Peep.Ember do
  use GenServer
  import Peep.Util

  require Logger

  def start_link(name) do
    ember_app_path = Application.get_env :peep, :ember_app, "ui"
    GenServer.start_link(__MODULE__, ember_app_path, name: name)
  end

  @doc """
  Start the Ember server
  """
  def init(path_to_app) do
    {:ok, app_path} = app_directory(path_to_app)

    {:ok, args} = ember_args_for :build
    port = ember_command app_path, args

    {:ok, %{port: port}}
  end

  @doc """
  Handle out from the Ember server
  """
  def handle_info({_port, {:data, data}}, state) do
    Logger.info data
    {:noreply, state}
  end

  @doc """
  Handle exit from the Ember server
  """
  def handle_info({_port, {:exit_status, status}}, _state) do
     Logger.debug "Error #{status} in Ember app"
     exit(:normal)
  end

  def handle_info(message, state) do
    IO.debug message
    {:noreply, state}
  end

  defp ember_args_for(task) do
    case task do
      :build -> {:ok, ["build", "--watch"]}
      _ -> :error
    end
  end
end
