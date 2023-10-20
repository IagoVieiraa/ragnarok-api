defmodule RagnarokWeb.PageController do
  use RagnarokWeb, :controller

  def get_classes(conn, _params) do
    classes = gen_classes()
    IO.inspect(conn)

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(%{classes: classes}))
  end

  def get_by_class_name(conn, %{"name" => name}) do
    classes = gen_classes()

    case Enum.find(classes, fn c -> c.name == name end) do
      nil ->
        conn
        |> put_status(404)
        |> put_resp_content_type("application/json")
        |> send_resp(404, Poison.encode!(%{error: "Class not found"}))

      class ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, Poison.encode!(%{class: class}))
    end
  end

  def create_class(conn, %{"name" => name, "description" => description}) do
    class = %Class{name: name, description: description}
    classes = gen_classes() ++ [class]

    :ok = Application.put_env(:ragnarok_web, :classes, classes)

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(201, Poison.encode!(%{class: class}))

    # Atualiza a lista de classes com a nova classe adicionada

  end

  defp gen_classes(classes \\ []) do
    case classes do
      [] ->
        classes = [
          %Class{name: "Espadachim", description: "Classe de combate corpo a corpo"},
          %Class{name: "Mago", description: "Classe de suporte mágico"},
          %Class{name: "Arqueiro", description: "Classe de combate à distância"},
          %Class{name: "Noviço", description: "Classe de suporte divino"}
        ]
        Enum.reverse(classes)
      _ ->
        classes
    end
  end
end
