defmodule Ragnarok.Repo.Migrations.AddHpToCharacters do
  use Ecto.Migration

  def change do
    alter table(:characters) do
      add :hp, :integer
    end
  end
end
