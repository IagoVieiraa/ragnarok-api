defmodule RagnarokWeb.ClassView do
  def render("list.json") do
    %{classes: classes}
  end
end
