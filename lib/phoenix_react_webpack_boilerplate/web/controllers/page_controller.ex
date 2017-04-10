defmodule PhoenixReactWebpackBoilerplate.Web.PageController do
  use PhoenixReactWebpackBoilerplate.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
