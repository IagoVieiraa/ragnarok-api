defmodule Ragnarok.Repo.Migrations.RemoveDuplicateClasses do
  use Ecto.Migration

  def up do
    # Fetch all classes
    classes = Ragnarok.Repo.all(Ragnarok.Class)

    # Group classes by name
    grouped_classes = Enum.group_by(classes, & &1.name)

    # Find duplicates
    duplicates = Enum.filter(grouped_classes, fn {_, v} -> length(v) > 1 end)

    # Remove duplicates
    for {_, duplicate_classes} <- duplicates do
      # Keep the first one
      [first_class | rest_classes] = duplicate_classes

      # Delete the rest
      for class <- rest_classes do
        Ragnarok.Repo.delete(class)
      end
    end
  end

  def down do
    # We cannot restore deleted duplicates
  end
end
