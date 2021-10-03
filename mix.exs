defmodule AWS_Bootstrap.MixProject do
  use Mix.Project

  def project do
    [
      app: :aws_bootstrap,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [
        :logger,
        :plug_logger_json
      ],
      mod: {AWS_Bootstrap.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug_logger_json, "~> 0.7.0"},
      {:poison, "~> 4.0.0"},
      {:logger_file_backend, "~> 0.0.12"},
      {:plug_cowboy, "~> 2.0"}
    ]
  end
end
