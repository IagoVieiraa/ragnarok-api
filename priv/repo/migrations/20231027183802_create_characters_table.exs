defmodule Ragnarok.Repo.Migrations.CreateCharacters do
  use Ecto.Migration

  def change do
    create table(:characters) do
      add :name, :string
      add :level, :integer
      add :class_id, references(:classes, on_delete: :nothing)

      timestamps()
    end
  end
end
