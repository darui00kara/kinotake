defmodule KinoTake.RunnerHandlerWatcher do
  use GenServer
  alias KinoTake.RunnerHandler
  alias KinoTake.EventManager

  ## Client API

  def start_link(event_manager) do
    GenServer.start_link(__MODULE__, event_manager, name: __MODULE__)
  end

  ## Callback functions

  def init(event_manager) do
    start_handler(event_manager)
  end

  def handle_info({:DOWN, _, _, {EventManager, _node}, _reason}, _from) do
    {:stop, "EventManager down.", []}
  end

  def handle_info({:gen_event_EXIT, _handler, _reason}, event_manager) do
    {:ok, event_manager} = start_handler(event_manager)
    {:noreply, event_manager}
  end

  defp start_handler(event_manager) do
    case GenEvent.add_mon_handler(event_manager, RunnerHandler, []) do
     :ok -> {:ok, event_manager}
     {:error, reason} -> {:stop, reason}
    end
  end
end