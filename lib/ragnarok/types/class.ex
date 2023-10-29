defmodule Ragnarok.Class do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:name, :description, :stats, :skills]}
  schema "classes" do
    field :name, :string
    field :description, :string
    field :stats, :map
    field :skills, {:array, :string}

    timestamps()
  end

  def changeset(class, attrs) do
    class
    |> cast(attrs, [:name, :description, :stats, :skills])
    |> validate_required([:name, :description, :stats, :skills])
  end
end
