defmodule RagnarokWeb.PageController do
  use RagnarokWeb, :controller

  alias Ragnarok.Repo
  alias Ragnarok.Class

  def get_classes(conn, _params) do
    classes = gen_classes()

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

  def create_class(conn, %{"name" => name, "description" => description, "stats" => stats, "skills" => skills} = params) do
    changeset = Class.changeset(%Class{}, %{name: name, description: description, stats: stats, skills: skills})

    case Repo.insert(changeset) do
      {:ok, class} ->
        classes = gen_classes()

        conn
        |> put_status(201)
        |> put_resp_content_type("application/json")
        |> send_resp(201, Poison.encode!(%{class: class, classes: classes}))

      {:error, changeset} ->
        conn
        |> put_status(422)
        |> put_resp_content_type("application/json")
        |> send_resp(422, Poison.encode!(%{errors: changeset}))
    end
  end

  defp gen_classes() do
    Repo.all(Class)
  end
end
