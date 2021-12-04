defmodule SpaceMission.MixProject do
  use Mix.Project

  def project do
    [
      app: :space_mission,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      name: "SpaceMission",
      docs: [main: "SpaceMission", extras: ["README.md"]]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {SpaceMission.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ecto_sql, "~> 3.7.0"},
      {:postgrex, "~> 0.15.0"},
      {:libgraph, "~> 0.7"},
      {:ex_doc, "~>0.24", only: :dev, runtime: false}
    ]
  end
end
