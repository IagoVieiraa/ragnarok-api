defmodule Ragnarok.Repo.Migrations.AddUniqueIndexToNameClasses do
  use Ecto.Migration

  def change do
    create unique_index(:classes, [:name])
  end
end
