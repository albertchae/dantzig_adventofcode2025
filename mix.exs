defmodule Dantzig.MixProject do
  use Mix.Project

  @version "0.2.1"

  def project do
    [
      app: :dantzig_adventofcode2025,
      version: @version,
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      compilers: Mix.compilers() ++ [:download_solver_binary],
      aliases: [
        "compile.download_solver_binary": &download_solver_binary/1
      ],
      elixirc_paths: elixirc_paths(Mix.env()),
      package: package(),
      name: "Dantzig for Advent of Code 2025",
      description: "Fork of tmbb/dantzig tweaked for Advent of Code 2025",
      source_url: "https://github.com/albertchae/dantzig_adventofcode2025"
    ]
  end

  defp download_solver_binary(_) do
    Dantzig.HiGHSDownloader.maybe_download_for_target()
  end

  def elixirc_paths(env) when env in [:dev, :test], do: ["lib", "test/support"]
  def elixirc_paths(:prod), do: ["lib"]

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [
        :logger,
        :public_key,
        :crypto,
        inets: :optional,
        ssl: :optional
      ]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:nimble_parsec, "~> 1.4"},
      {:ex_doc, "~> 0.36", only: :dev, runtime: false},
      {:stream_data, "~> 1.1", only: [:test, :dev]}
    ]
  end

  defp package() do
    [
      # These are the default files included in the package
      files: ~w(lib priv .formatter.exs mix.exs README* LICENSE* CHANGELOG*),
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/albertchae/dantzig_adventofcode2025"}
    ]
  end
end
