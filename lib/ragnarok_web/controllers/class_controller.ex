defmodule RagnarokWeb.ClassController do
  use RagnarokWeb, :controller
  alias RagnarokWeb.ClassView
  alias RagnarokWeb.ClassServer

  def get_classes(conn, _params) do
    case ClassServer.get_classes() do
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
    case ClassServer.get_class_by_name(name) do
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
    case ClassServer.get_class_by_id(id) do
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

  def update_class(conn, %{"id" => id} = params) do
    case ClassServer.update_class(id, params) do
      {:ok, class} ->
        conn
        |> put_status(200)
        |> put_view(ClassView)
        |> render("updated.json", class: class)

      {:error, _changeset} ->
        conn
        |> put_status(422)
        |> put_resp_content_type("application/json")
        |> send_resp(422, Poison.encode!(%{errors: "Class already exists!"}))
    end
  end

  def create_class(conn, params) do
    case ClassServer.create_class(params) do
      {:ok, class} ->
        conn
        |> put_status(201)
        |> put_view(ClassView)
        |> render("create.json", class: class)

      {:error, _changeset} ->
        conn
        |> put_status(422)
        |> put_resp_content_type("application/json")
        |> send_resp(422, Poison.encode!(%{errors: "Class already exists!"}))
    end
  end

  def delete_class(conn, %{"id" => id}) do
    case ClassServer.delete_class(id) do
      {:ok, _} ->
        conn
        |> put_status(200)
        |> put_view(ClassView)
        |> render("delete.json", info: "Class deleted successfully")

      {:error, _} ->
        conn
        |> put_status(404)
        |> put_resp_content_type("application/json")
        |> send_resp(404, Poison.encode!(%{error: "Class not found"}))
    end
  end
end
