defmodule UltimatePhoenixBoilerplate.Web.PageControllerTest do
  use UltimatePhoenixBoilerplate.Web.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Hello UltimatePhoenixBoilerplate!"
  end
end
