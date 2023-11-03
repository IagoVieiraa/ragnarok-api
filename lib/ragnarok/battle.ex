defmodule Ragnarok.Battle do
  def battle(character1, character2) do
    case character1.hp > 0 and character2.hp > 0 do
      true ->
        damage =
          Map.get(character1.class.stats, "attack", 0) -
            Map.get(character2.class.stats, "defense", 0)

        updated_character2 = Map.put(character2, :hp, character2.hp - damage)
        IO.puts("#{character1.name} attacks #{character2.name} for #{damage} damage.")
        battle(character1, updated_character2)

      false ->
        winner = if character1.hp > 0, do: character1.name, else: character2.name
        IO.puts("#{winner} wins the battle!")
    end
  end
end
