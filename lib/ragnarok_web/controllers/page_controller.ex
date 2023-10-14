defmodule RagnarokWeb.PageController do
  use RagnarokWeb, :controller

  import Poison

  def list_classes(conn, _params) do
    classes = ["Espadachim", "Mago", "Arqueiro", "Noviço"]
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(%{classes: classes}))
  end
end
