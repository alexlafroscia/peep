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

## Usage

Peep provides two many Plugs that should be used to serve your Ember application; one to handle your "regular" static assets (CSS and JavaScript files) and one to serve the `index.html` file.

### Peep.Plug.Assets

The first of these is used to serve the static assets.  I can be added to your `endpoint.ex` file like so:

```ex
defmodule MyCoolApp.Endpoint do
  use Phoenix.Endpoint, otp_app: :mycoolapp

  ...

  plug Peep.Plug.Assets

  ...
end
```

The key here is that it is added toward the top of the `endpoint.ex` file, near where the regular `Plug.Static` plug would be found.

### Peep.Plug.Index

This plug is used within the router to catch any `NoRouteError`s thrown, and to instead serve up the Ember application's `index.html`.  This allows any API routes to be matched first, but in the case that none match, have the Ember app be used instead.  **Note:** This means that your Ember application will be responsible for any `404` requests to your application.

The usage of this plug is like so; it should be added to your `web/router.ex` file, just after you `use` the `:router` plug:

```ex
defmodule MyCoolApp.Router do
  use MyCoolApp.Web, :router
  use Peep.Plug.Index

  ...
end
```

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

## New Project Setup

If you're setting up a new Phoenix/Ember application and want to use Peep, here are my suggestions on how to best do that:

```bash
$ mix phoenix.new my_cool_app --no-brunch
$ cd my_cool_app
$ git init
$ ember new my_cool_app --skip-git --directory ui
```

This will create both a Phoenix application, without the default Brunch configuration, and an Ember application inside of it with the same name inside a directory called `ui`.  If you choose to use a directory other than `ui`, you just need to change the configuration for Peep (see the above section).
