defmodule PhoenixReactWebpackBoilerplate.Web.PageControllerTest do
  use PhoenixReactWebpackBoilerplate.Web.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Hello PhoenixReactWebpackBoilerplate!"
  end
end
