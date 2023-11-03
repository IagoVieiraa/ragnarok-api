defmodule RagnarokWeb.BattleController do
  use RagnarokWeb, :controller
  alias Ragnarok.Battle
  alias Ragnarok.Repo
  alias Ragnarok.Character

  def create(conn, %{"character1_id" => id1, "character2_id" => id2}) do
    character1 = Repo.get!(Character, id1) |> Repo.preload(:class)
    character2 = Repo.get!(Character, id2) |> Repo.preload(:class)
    result = Battle.battle(character1, character2)
    json(conn, %{result: result})
  end
end
