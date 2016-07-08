defmodule KinoTake.Supervisor do
  use Supervisor
  alias KinoTake.EventSupervisor
  alias KinoTake.Loader

  def start_link(args) do
    Supervisor.start_link(__MODULE__, args, name: __MODULE__)
  end

  def init(_args) do
    children = [
      supervisor(EventSupervisor, []),
      worker(Loader, [], [id: :unit_loader,
                          restart: :permanent,
                          shutdown: 10000,
                          function: :start_link,
                          modules: [:loader]])
    ]
    supervise(children, strategy: :one_for_one)
  end
end