defmodule Ragnarok.Classes do
  import Ecto.Changeset

  defstruct name: nil, description: nil, stats: nil, skills: nil

  def changeset(class, params \\ %{}) do
    class
    |> cast(params, [:name, :description, :stats, :skills])
    |> validate_required([:name, :description, :stats, :skills])
  end

  def __changeset__(_class, _params) do
    %{}
  end
end
