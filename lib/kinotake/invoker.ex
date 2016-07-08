defmodule KinoTake.Invoker do
  defmacro __using__(_options) do
    quote do
      import unquote(__MODULE__)
    end
  end

  defmacro invoke(unit_name, function_name, options \\ [], run_default) do
    run_default =
      case run_default do
        [do: block] ->
          quote do
            unquote(block)
          end
        _ ->
          quote do
            try(unquote(run_default))
          end
      end

    quote bind_quoted: binding do
      KinoTake.Runner.run(__ENV__, unit_name, function_name, options, run_default)
    end
  end
end