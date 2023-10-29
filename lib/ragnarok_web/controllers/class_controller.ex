defmodule RagnarokWeb.ClassController do
  use RagnarokWeb, :controller
  alias Ragnarok.Repo
  alias Ragnarok.Class
  alias RagnarokWeb.ClassView

  def get_classes(conn, params) do
    IO.inspect(params)
    classes = gen_classes()

    case classes do
      [] ->
        conn
        |> put_status(404)
        |> put_resp_content_type("application/json")
        |> send_resp(404, Poison.encode!(%{error: "Classes empty"}))

      _ ->
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
          _params
      ) do
    case Repo.get_by(Class, name: name) do
      nil ->
        changeset =
          Class.changeset(%Class{}, %{
            name: name,
            description: description,
            stats: stats,
            skills: skills
          })

        case Repo.insert(changeset) do
          {:ok, class} ->
            classes = gen_classes()

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

      _ ->
        conn
        |> put_status(422)
        |> put_resp_content_type("application/json")
        |> send_resp(
          422,
          Poison.encode!(%{errors: %{name: "Class with name #{name} already exists"}})
        )
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
