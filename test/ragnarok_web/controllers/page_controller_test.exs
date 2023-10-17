defmodule PageControllerTest do
  use RagnarokWeb.ConnCase
  alias RagnarokWeb.PageController, as: PageController

  test "GET /api/classes returns 200", %{conn: conn} do
    conn = get(conn, "/api/classes")
    assert conn.status == 200
  end

  test "GET /api/classes returns a list of classes", %{conn: conn} do
    conn = get(conn, "/api/classes")
    assert conn.resp_body =~ "Warrior"
    assert conn.resp_body =~ "Mage"
    assert conn.resp_body =~ "Rogue"
  end
end
