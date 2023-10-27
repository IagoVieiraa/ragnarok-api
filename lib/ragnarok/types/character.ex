defmodule Ragnarok.Character do
  use Ecto.Schema
  import Ecto.Changeset

  schema "personagens" do
    field :name, :string
    field :level, :integer
    belongs_to :class, Ragnarok.Class

    timestamps()
  end

  def changeset(personagem, attrs) do
    personagem
    |> cast(attrs, [:name, :level, :class_id])
    |> validate_required([:name, :level, :class_id])
  end
end
