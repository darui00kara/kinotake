defmodule KinoTake.RunnerHandler do
  use GenEvent

  def init(_opts) do
    messages = %{}
    {:ok, messages}
  end

  def handle_call(:stop, messages) do
    {:remove_handler, messages}
  end

  def handle_event({:unit_started, {unit_name, function_name}}, messages) do
    IO.inspect {:unit_started, {unit_name, function_name}}
    {:ok, messages}
  end

  def handle_event({:unit_errored, {env, unit_name, function_name, _kind, error}}, messages)do
    %{module: mod, function: {function, arity}, file: file, line: line} = env
    IO.inspect "ErrorInfo: #{inspect error}"
    IO.inspect "CallUnit: Unit=#{inspect unit_name}, Function=#{inspect function_name}"
    IO.inspect "CallModule: Module=#{inspect mod}, Function=#{inspect function}/#{inspect arity}"
    IO.inspect "File: File=#{inspect file}, Line=#{inspect line}"
    {:ok, messages}
  end

  def handle_event({:unit_deactive, {unit_name, function_name}}, messages)do
    IO.inspect {:unit_deactive, {unit_name, function_name}}
    {:ok, messages}
  end

  def handle_event({:unit_finished, {unit_name, function_name}}, messages) do
    IO.inspect {:unit_finished, {unit_name, function_name}}
    {:ok, messages}
  end

  def handle_event(_, messages) do
    IO.inspect "No event!!"
    {:ok, messages}
  end
end