defmodule KinoTake.ActiveIf do
  defmacro active_if(var \\ quote(do: _), contents) do
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
      def active?(unquote(var)), do: unquote(contents)
    end
  end
end