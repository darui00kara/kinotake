defmodule KinoTake.Loader do
  use GenServer

  ## Client API

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  #def start_load(unit_names \\ []) do
  #  GenServer.call(__MODULE__, {:start_load, unit_names})
  #end

  def exist_module?(unit_name) do
    GenServer.call(__MODULE__, {:exist_module?, unit_name})
  end

  def all_units do
    GenServer.call(__MODULE__, {:all_units})
  end

  def add_unit(unit_name) do
    GenServer.cast(__MODULE__, {:add_unit, unit_name})
  end

  ## Callback functions

  def init([]) do
    {:ok, Map.new}
  end

  #def handle_call({:start_load, unit_names}, _from, state) when is_list(unit_names) do
  #  state = Enum.reduce(unit_names, state,
  #     fn(unit_name, acc) -> Map.put(acc, unit_name, unit_name.__kinotake_unit__(:unit)) end)
  #
  #  {:reply, :ok, state}
  #end

  def handle_call({:exist_module?, unit_name}, _from, state) do
    {:reply, Map.get(state, unit_name) != nil, state}
  end

  def handle_call({:all_units}, _from, state) do
    {:reply, state, state}
  end

  def handle_cast({:add_unit, unit_name}, state) do
    ## ここでrequire_file (初期値(config)でUnitディレクトリパスを取得)
    {:noreply, Map.put(state, unit_name, unit_name.__unit__(:unit))}
  end

  def handle_info(_info, state) do
    {:noreply, state}
  end

  def terminate(_reason, _state) do
    :ok
  end

  def code_change(_old_vsn, state, _extra) do
    {:ok, state}
  end
end