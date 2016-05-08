defmodule Peep do
  use Application

  def start(_type, _args) do
    Peep.Supervisor.start_link
  end
end
