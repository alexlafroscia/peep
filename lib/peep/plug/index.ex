defmodule Peep.Plug.Index do
  defmacro __using__(_env) do
    quote do
      use Plug.ErrorHandler

      def call(conn, opts) do
        try do
          super(conn, opts)
        catch
          kind, reason ->
            Plug.ErrorHandler.__catch__(conn, kind, reason, &handle_errors/2)
        end
      end

      # Grab `NoRouteError` errors and serve the Ember app index
      defp handle_errors(conn, %{reason: %Phoenix.Router.NoRouteError{}} = ex) do
        conn
        |> send_file(200, Path.join(Peep.Util.ember_dist_dir, "index.html"))
      end
    end
  end
end
