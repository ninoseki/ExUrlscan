defmodule Urlscan.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_urlscan,
      version: "0.1.1",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: "Elixir API client for urlscan.io",
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],
      source_url: "https://github.com/ninoseki/ExUrlscan",
      package: package()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {ExUrlscan, []},
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 1.0", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.19", only: :dev},
      {:excoveralls, "~> 0.10", only: :test},
      {:exvcr, "~> 0.10", only: :test},
      {:httpoison, "~> 1.5"},
      {:mock, "~> 0.3.0", only: :test},
      {:poison, "~> 3.1"}
    ]
  end

  defp package() do
    [
      maintainers: ["Manabu Niseki"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/ninoseki/ExUrlscan"}
    ]
  end
end
