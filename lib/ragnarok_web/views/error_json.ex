defmodule RagnarokWeb.ErrorJSON do
  def render("404.json", _assigns) do
    %{error: "not_found"}
  end
end
