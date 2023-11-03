defmodule Ragnarok.Character do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:name, :level, :class_id, :hp]}
  schema "characters" do
    field :name, :string
    field :level, :integer
    field :hp, :integer
    belongs_to :class, Ragnarok.Class

    timestamps()
  end

  def changeset(character, attrs) do
    character
    |> cast(attrs, [:name, :level, :class_id, :hp])
    |> validate_required([:name, :level, :class_id, :hp])
  end
end
