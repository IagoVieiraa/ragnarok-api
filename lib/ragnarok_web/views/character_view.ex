defmodule RagnarokWeb.CharacterView do
  def render("list.json", %{character: character}) do
    %{
      data: %{
        character: character
      }
    }
  end

  def render("delete.json", %{info: _info}) do
    %{
      info: "Character deleted successfully"
    }
  end
end
