defmodule RagnarokWeb.PageController do
  use RagnarokWeb, :controller

  import Poison
  alias Ragnarok.Classes

  def list_classes(conn, _params) do
    classes = [
      %Class{name: "Warrior", description: "A strong and brave fighter", stats: %{attack: 10, defense: 8}, skills: ["Sword Mastery", "Shield Bash"]},
      %Class{name: "Mage", description: "A wise and powerful spellcaster", stats: %{attack: 8, defense: 6, magic: 12}, skills: ["Fireball", "Ice Storm", "Heal"]},
      %Class{name: "Rogue", description: "A sneaky and agile thief", stats: %{attack: 9, defense: 7, agility: 12}, skills: ["Backstab", "Pickpocket", "Stealth"]}
    ]
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(%{classes: classes}))
  end
end
