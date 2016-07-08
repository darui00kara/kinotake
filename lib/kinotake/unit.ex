defmodule KinoTake.Unit do
  defmacro __using__(_opts) do
    quote do
      Module.register_attribute __MODULE__, :unit_functions, accumulate: true,
                                                             persist: false
      @before_compile unquote(__MODULE__)
      import unquote(__MODULE__)
      import KinoTake.ActiveIf
    end
  end

  defmacro __before_compile__(_env) do
    quote do
      def __unit__(:unit) do
        %{name: __MODULE__, functions: @unit_functions}
      end
    end
  end

  defmacro function(func_name, var \\ quote(do: _), contents) do
    contents =
      case contents do
        [do: block] ->
          quote do
            unquote(block)
          end
        _ ->
          quote do
            try(unquote(contents))
          end
      end

    var      = Macro.escape(var)
    contents = Macro.escape(contents, unquote: true)

    quote bind_quoted: binding do
      KinoTake.Unit.__on_definition__(__ENV__, func_name)
      def unquote(func_name)(unquote(var)), do: unquote(contents)
    end
  end

  def __on_definition__(%{module: mod, file: file, line: line}, func_name) do
    Module.put_attribute(mod, :unit_functions,
                         %{name: func_name, tags: %{file: file, line: line}})
  end
end