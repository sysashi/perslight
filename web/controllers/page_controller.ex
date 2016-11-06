defmodule PL.PageController do
  use PL.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
