defmodule LineageOS.MixProject do
  use Mix.Project

  def project do
    [
      app: :lineageos,
      version: "0.1.0",
      elixir: "~> 1.13.3",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      escript: escript(),

      # Docs
      name: "LineageOS API",
      source_url: "https://github.com/NatoBoram/lineageos-elixir-api",
      homepage_url: "https://natoboram.github.io/lineageos-elixir-api",
      docs: [
        authors: ["Nato Boram"],
        extras: ["README.md", "LICENSE.md"]
      ]
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
      {:tzdata, "~> 0.1.8", override: true},
      {:ex_doc, "~> 0.27", only: :dev, runtime: false}
    ]
  end

  defp escript do
    [main_module: LineageOS.CLI]
  end
end
