defmodule Dunia.Mixfile do
  use Mix.Project

  @name Dunia
  @version "0.1.0"
  @description "Resilient background workers on top of GenStage and Redis"

  @repo_url "https://github.com/seivan/#{@name}"

  # Run "mix help deps" to learn about dependencies.

  @deps [
    {:tiled, path: "../TileMapParserElixir"}
  ]

  @dev_deps [
    {:dialyxir, "~> 0.5.1"},
    {:ex_doc, "~> 0.15"}
  ]

  @package [
    maintainers: ["Seivan Heidari"],
    licenses: ["MIT"],
    links: %{"GitHub" => @repo_url}
  ]

  def deps do
    dev_options = [only: [:dev], runtime: false]

    only_dev_no_runtime = fn
      {name, version, options} when is_list(options) -> {name, version, dev_options |> Keyword.merge(options)}
      {name, options} when is_list(options) -> {name, dev_options |> Keyword.merge(options)}
      {name, version} when is_binary(version) -> {name, version, dev_options}
    end

    @deps ++ (@dev_deps |> Enum.map(only_dev_no_runtime))
  end

  def project do
    in_production = Mix.env() == :prod

    [
      app: @name |> Macro.underscore() |> String.to_atom(),
      version: @version,
      elixir: "~> 1.6",
      start_permanent: in_production,
      build_embedded: true,
      deps: __MODULE__.deps(),

      # Hex
      package: @package,
      description: @description,

      # Docs
      name: @name,
      docs: [
        main: @name,
        source_ref: "#{@version}",
        source_url: @repo_url,
        homepage_url: @repo_url,
        extras: ["README.md"]
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [extra_applications: [:logger]]
  end
end
