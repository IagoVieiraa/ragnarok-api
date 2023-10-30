defmodule RagnarokWeb.ClassController do
  use RagnarokWeb, :controller
  alias Ragnarok.Repo
  alias Ragnarok.Class
  alias RagnarokWeb.ClassView
  alias RagnarokWeb.ClassServer

  def get_classes(conn, params) do

    case ClassServer.get_classes do
      [] ->
        conn
        |> put_status(404)
        |> put_resp_content_type("application/json")
        |> send_resp(404, Poison.encode!(%{error: "Classes empty"}))

      classes ->
        conn
        |> put_status(200)
        |> put_view(ClassView)
        |> render("list.json", classes: classes)
    end
  end

  def get_class_by_name(conn, %{"name" => name}) do
    classes = gen_classes()

    case Enum.find(classes, fn c -> c.name == name end) do
      nil ->
        conn
        |> put_status(404)
        |> put_resp_content_type("application/json")
        |> send_resp(404, Poison.encode!(%{error: "Class not found"}))

      class ->
        conn
        |> put_status(200)
        |> put_view(ClassView)
        |> render("list.json", class: class)
    end
  end

  def get_class_by_id(conn, %{"id" => id}) do
    class = Repo.get(Class, id)

    case class do
      nil ->
        conn
        |> put_status(404)
        |> put_resp_content_type("application/json")
        |> send_resp(404, Poison.encode!(%{error: "Class not found"}))

      _ ->
        conn
        |> put_status(200)
        |> put_view(ClassView)
        |> render("list.json", class: class)
    end
  end

  def update_class(conn, %{"id" => id} = params) do
    class = Repo.get(Class, id)

    case class do
      nil ->
        conn
        |> put_status(404)
        |> put_resp_content_type("application/json")
        |> send_resp(404, Poison.encode!(%{error: "Class not found"}))

      _ ->
        changeset = Class.changeset(class, params)

        case Repo.update(changeset) do
          {:ok, class} ->
            conn
            |> put_status(200)
            |> put_view(ClassView)
            |> render("updated.json", class: class)

          {:error, error} ->
            conn
            |> put_status(422)
            |> put_resp_content_type("application/json")
            |> send_resp(422, Poison.encode!(%{errors: error}))
        end
    end
  end

    def create_class(
      conn,
      %{"name" => name, "description" => description, "stats" => stats, "skills" => skills} =
        params
    ) do
  case GenServer.call(ClassServer, {:create_class, params}) do
    {:ok, class} ->
      conn
      |> put_status(201)
      |> put_view(ClassView)
      |> render("create.json", class: class)

    {:error, changeset} ->
      conn
      |> put_status(422)
      |> put_resp_content_type("application/json")
      |> send_resp(422, Poison.encode!(%{errors: changeset}))
     end
    end

  def delete_class(conn, %{"id" => id}) do
    class = Repo.get(Class, id)

    case class do
      nil ->
        conn
        |> put_status(404)
        |> put_resp_content_type("application/json")
        |> send_resp(404, Poison.encode!(%{error: "Class not found"}))

      _ ->
        Repo.delete(class)

        conn
        |> put_status(200)
        |> put_view(ClassView)
        |> render("delete.json", info: "Class deleted successfully")
    end
  end

  defp gen_classes() do
    Repo.all(Class)
  end
end
