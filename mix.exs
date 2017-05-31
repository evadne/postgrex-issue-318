defmodule Sample.Mixfile do
  use Mix.Project

  def project do
    [app: :sample,
     version: "0.0.1",
     elixir: "~> 1.4",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [] ++ Mix.compilers,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [mod: {Sample.Application, []},
     extra_applications: [:logger, :runtime_tools]]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [{:postgrex, ">= 0.0.0"}]
  end
end
