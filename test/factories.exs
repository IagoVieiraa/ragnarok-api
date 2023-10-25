defmodule Ragnarok.Factories do
  use Ecto.Factory

  def factory(:class) do
    %Ragnarok.Class{
      name: "Warrior",
      description: "A strong melee fighter",
      stats: %{"attack" => 10, "defense" => 5, "hp" => 2},
      skills: ["Slash", "Charge"]
    }
  end
end
