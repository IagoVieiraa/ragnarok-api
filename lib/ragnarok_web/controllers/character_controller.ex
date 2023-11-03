defmodule RagnarokWeb.CharacterController do
  use RagnarokWeb, :controller

  alias Ragnarok.Repo
  alias Ragnarok.Character
  alias Ragnarok.Class
  alias RagnarokWeb.CharacterView

  def get_character(conn, %{"id" => id}) do
    character = Repo.get(Character, id)

    case character do
      nil ->
        conn
        |> put_status(404)
        |> put_resp_content_type("application/json")
        |> send_resp(404, Poison.encode!(%{error: "Character not found"}))

      _ ->
        conn
        |> put_status(200)
        |> put_view(CharacterView)
        |> render("list.json", character: character)
    end
  end

  def create_character(conn, %{
        "name" => name,
        "level" => level,
        "hp" => hp,
        "class_id" => class_id
      }) do
    class = Repo.get(Class, class_id)

    changeset =
      Character.changeset(%Character{}, %{name: name, level: level, class_id: class_id, hp: hp})

    case Repo.insert(changeset) do
      {:ok, character} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(201, Poison.encode!(%{character: character}))

      {:error, error} ->
        conn
        |> put_status(422)
        |> put_resp_content_type("application/json")
        |> send_resp(422, Poison.encode!(%{error: error}))
    end
  end

  def delete_character(conn, %{"id" => id}) do
    character = Repo.get(Character, id)

    case character do
      nil ->
        conn
        |> put_status(404)
        |> put_resp_content_type("application/json")
        |> send_resp(404, Poison.encode!(%{error: "Character not found"}))

      _ ->
        Repo.delete(character)

        conn
        |> put_status(200)
        |> put_view(CharacterView)
        |> render("delete.json", info: "Character deleted successfully")
    end
  end

  defp gen_characters() do
    Repo.all(Character)
  end
end
