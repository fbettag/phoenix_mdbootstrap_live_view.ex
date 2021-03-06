defmodule PhoenixMDBootstrapLiveView.MixProject do
  use Mix.Project

  @project_url "https://github.com/fbettag/phoenix_mdbootstrap_live_view.ex"

  def project do
    [
      app: :phoenix_mdbootstrap_live_view,
      version: "0.1.3",
      elixir: "~> 1.7",
      source_url: @project_url,
      homepage_url: @project_url,
      name: "Phoenix Material Design Bootstrap LiveView",
      description: "Material Design Bootstrap 4 LiveViews for Phoenix Applications",
      package: package(),
      aliases: aliases(),
      deps: deps()
    ]
  end

  defp package do
    [
      name: "phoenix_mdbootstrap_live_view",
      maintainers: ["Franz Bettag"],
      licenses: ["MIT"],
      links: %{"GitHub" => @project_url},
      files: ~w(lib priv LICENSE README.md mix.exs)
    ]
  end

  defp aliases do
    [credo: "credo -a --strict"]
  end

  defp deps do
    [
      {:phoenix_live_view, "~> 0.15"},
      {:ex_doc, "~> 0.19", only: :dev},
      {:credo, github: "rrrene/credo", only: [:dev, :test]}
    ]
  end
end
