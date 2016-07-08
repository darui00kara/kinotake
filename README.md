# Kinotake

## Usage

add `{:kinotake, xxx}` to `deps` of your `mix.exs`

```elixir
defp deps do
  [{:phoenix, "~> 1.2.0"},
   {:phoenix_pubsub, "~> 1.0"},
   {:phoenix_ecto, "~> 3.0"},
   {:postgrex, ">= 0.0.0"},
   {:phoenix_html, "~> 2.6"},
   {:phoenix_live_reload, "~> 1.0", only: :dev},
   {:gettext, "~> 0.11"},
   {:cowboy, "~> 1.0"},
   {:kinotake, github: "darui00kara/kinotake", branch: "master"}] ## Add it
end
```

add `:kinotake` to `application` of your `mix.exs`

```elixir
def application do
  [mod: {KinotakeExampleInPhoenix, []},
   applications: [:phoenix,
                  :phoenix_pubsub,
                  :phoenix_html,
                  :cowboy,
                  :logger,
                  :gettext,
                  :phoenix_ecto,
                  :postgrex,
                  :kinotake]] ## Add it
end
```