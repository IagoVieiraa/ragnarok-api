defmodule Ragnarok.Repo.Migrations.CreateClassesTable do
  use Ecto.Migration

  def change do
    create table(:classes) do
      add :name, :string
      add :description, :string
      add :stats, :map
      add :skills, {:array, :string}

      timestamps()
  end
end
end
