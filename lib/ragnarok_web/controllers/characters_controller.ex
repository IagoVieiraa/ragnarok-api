defmodule RagnarokWeb.CharacterController do
  use RagnarokWeb, :controller

  alias Ragnarok.Repo
  alias Ragnarok.Character
  alias Ragnarok.Class

  def create_character(conn, %{"name" => name, "level" => level, "class" => class}) do
    class = Repo.get(Class, class)

    changeset = Character.changeset(%Character{}, %{name: name, level: level, class: class})

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

  defp gen_characters() do
    Repo.all(Character)
  end
end
