defmodule Ragnarok.Class do
  use Ecto.Schema

  schema "classes" do
    field :name, :string
    field :description, :string
    field :stats, :map
    field :skills, {:array, :string}

    timestamps()
  end
end
