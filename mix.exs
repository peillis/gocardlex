defmodule Gocardlex.Mixfile do
  use Mix.Project

  def project do
    [
      app: :gocardlex,
      version: "1.0.4",
      package: package(),
      elixir: "~> 1.15",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [
      extra_applications: [:logger],
      mod: {Gocardlex, []}
    ]
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:ex_doc, "~> 0.37", only: :dev},
      {:jason, "~> 1.4"},
      {:tesla, "~> 1.14"},
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false}
    ]
  end

  defp package do
    [
      maintainers: ["peillis"],
      licenses: ["MIT"],
      description: "Elixir wrapper for the GoCardless API",
      links: %{"GitHub" => "https://github.com/peillis/gocardlex"}
    ]
  end
end
