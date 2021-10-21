defmodule LineageOS.MixProject do
  use Mix.Project

  def project do
    [
      app: :lineageos,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      escript: escript()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 1.8"},
      {:poison, "~> 5.0"},
      {:tzdata, "~> 0.1.8", override: true}
    ]
  end

  defp escript do
    [main_module: LineageOS.CLI]
  end
end
