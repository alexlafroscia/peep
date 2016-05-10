defmodule Peep.Plug.Assets do
  use Plug.Builder

  plug Plug.Static,
    at: "/",
    from: Peep.Util.ember_dist_dir,
    gzip: false,
    only: ~w(assets tests crossdomain.xml robots.txt testem.js)
end
