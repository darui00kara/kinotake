defmodule KinoTake.EventManager do
  def start_link do
    GenEvent.start_link [{:name, __MODULE__}]
  end

  def unit_started(unit_name, function_name) do
    GenEvent.notify(KinoTake.EventManager,
                    {:unit_started, {unit_name, function_name}})
  end

  def unit_errored(env, unit_name, function_name, kind, error) do
    GenEvent.notify(KinoTake.EventManager,
                    {:unit_errored, {env, unit_name, function_name, kind, error}})
  end

  def unit_deactive(unit_name, function_name) do
    GenEvent.notify(KinoTake.EventManager,
                    {:unit_deactive, {unit_name, function_name}})
  end

  def unit_finished(unit_name, function_name) do
    GenEvent.notify(KinoTake.EventManager,
                    {:unit_finished, {unit_name, function_name}})
  end
end