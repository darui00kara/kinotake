defmodule KinoTake.Runner do
  alias KinoTake.EventManager

  def run(env, unit_name, function_name, options, run_default) do
    case exec_function(env, unit_name, function_name, options[:locals]) do
      {:ok, result} ->
        EventManager.unit_finished(unit_name, function_name)
        result
      {:error, _unit, _function} ->
        EventManager.unit_finished(unit_name, function_name)
        run_default
    end
  end

  def exec_function(env, unit_name, function_name, function_args \\ []) do
    if unit_name.active? function_args do
      EventManager.unit_started(unit_name, function_name)
      {:ok, apply(unit_name, function_name, [function_args])}
    else
      EventManager.unit_deactive(unit_name, function_name)
      {:error, unit_name, function_name}
    end
  catch
    kind, error ->
      EventManager.unit_errored(env, unit_name, function_name, kind, error)
      {:error, unit_name, function_name}
  end
end