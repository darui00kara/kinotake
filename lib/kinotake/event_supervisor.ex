defmodule KinoTake.EventSupervisor do
  use Supervisor
  alias KinoTake.EventManager
  alias KinoTake.RunnerHandlerWatcher

  def start_link do
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    children = [
      worker(EventManager, []),
      worker(RunnerHandlerWatcher, [EventManager])
    ]
    supervise(children, strategy: :one_for_one)
  end
end