# Peep

Help run an Ember CLI application from Elixir/Phoenix

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add peep to your list of dependencies in `mix.exs`:

        def deps do
          [{:peep, "~> 0.0.1"}]
        end

  2. Ensure peep is started before your application:

        def application do
          [applications: [:peep]]
        end

## Configuration

Peep can be configured as such, in the `config/config.exs` file for your application.

| Config Option    | Description                                               |
| :--              | :--                                                       |
| `ember_app`      | Path to root of Ember app, relative to project root       |
| `ember_path`     | Path to Ember executable, relative to `ember_app`         |
| `ember_dist_dir` | Name of the subdirectory that the Ember app is built into |

The default values are below:

```exs
config :peep,
    ember_app: "ui",
    ember_path: "./node_modules/.bin/ember",
    ember_dist_dir: "dist"
```
