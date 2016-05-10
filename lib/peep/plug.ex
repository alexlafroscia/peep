defmodule Peep.Plug do
  defmacro ember_build_dir do
    quote do
      plug Plug.Static,
        at: "/", from: unquote(Peep.Util.ember_dist_dir), gzip: false,
        only: ~w(assets tests crossdomain.xml index.html robots.xt testem.js)
    end
  end
end
