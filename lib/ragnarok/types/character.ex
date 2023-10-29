defmodule Ragnarok.Character do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:name, :level, :class_id]}
  schema "characters" do
    field :name, :string
    field :level, :integer
    belongs_to :class, Ragnarok.Class

    timestamps()
  end

  def changeset(character, attrs) do
    character
    |> cast(attrs, [:name, :level, :class_id])
    |> validate_required([:name, :level, :class_id])
  end
end
