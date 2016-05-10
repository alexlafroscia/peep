defmodule Peep.Ember do
  use GenServer
  import Peep.Util

  require Logger

  def start_link(_name) do
    GenServer.start_link(__MODULE__, :ok, name: Peep.Ember)
  end

  @doc """
  Start the Ember server
  """
  def init(:ok) do
    {:ok, app_path} = ember_app_path

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
