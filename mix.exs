defmodule PhoenixMDBootstrapLiveView.MixProject do
  use Mix.Project

  @version "1.5.3"

  # If the elixir requirement is updated, we need to make the installer
  # use at least the minimum requirement used here. Although often the
  # installer is ahead of Phoenix itself.
  @elixir_requirement "~> 1.7"

  def project do
    [
      app: :phoenix_mdbootstrap_live_view,
      version: @version,
      elixir: @elixir_requirement,
      deps: deps(),
      package: package(),
      lockfile: lockfile(),
      consolidate_protocols: Mix.env() != :test,
      xref: [
        exclude: [
          {IEx, :started?, 0},
          Ecto.Type,
          :ranch,
          :cowboy_req,
          Plug.Adapters.Cowboy.Conn,
          Plug.Cowboy.Conn,
          Plug.Cowboy
        ]
      ],
      elixirc_paths: elixirc_paths(Mix.env()),
      name: "Phoenix Material Design Bootstrap LiveView",
      source_url: "https://github.com/phoenixframework/phoenix",
      homepage_url: "https://www.phoenixframework.org",
      description: """
      Productive. Reliable. Fast. A productive web framework that
      does not compromise speed or maintainability.
      """
    ]
  end

  defp elixirc_paths(:docs), do: ["lib", "installer/lib"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:phoenix_live_view, "~> 0.13.0"},
    ]
  end

  defp lockfile() do
    case System.get_env("COWBOY_VERSION") do
      "1" <> _ -> "mix-cowboy1.lock"
      _ -> "mix.lock"
    end
  end

  defp package do
    [
      maintainers: ["Franz Bettag"],
      licenses: ["MIT"],
      links: %{github: "https://github.com/phoenixframework/phoenix"},
      files: ~w(assets/js lib priv CHANGELOG.md LICENSE.md mix.exs package.json README.md .formatter.exs)
    ]
  end
end
