defmodule RagnarokWeb.PageController do
  use RagnarokWeb, :controller

  def get_classes(conn, _params) do
    classes = create_classes()

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(%{classes: classes}))
  end

  def get_by_class_name(conn, %{"name" => name}) do
    classes = create_classes()

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

  defp create_classes() do
    [
      %Class{
        name: "Warrior",
        description: "A strong and brave fighter",
        stats: %{attack: 10, defense: 8},
        skills: ["Sword Mastery", "Shield Bash"]
      },
      %Class{
        name: "Mage",
        description: "A wise and powerful spellcaster",
        stats: %{attack: 8, defense: 6, magic: 12},
        skills: ["Fireball", "Ice Storm", "Heal"]
      },
      %Class{
        name: "Rogue",
        description: "A sneaky and agile thief",
        stats: %{attack: 9, defense: 7, agility: 12},
        skills: ["Backstab", "Pickpocket", "Stealth"]
      }
    ]
  end
end
