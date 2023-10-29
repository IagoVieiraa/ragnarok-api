defmodule RagnarokWeb.ClassView do
  import Phoenix.LiveView

  def render("list.json", %{classes: classes}) do
    classes_with_id =
      Enum.map(classes, fn class ->
        %{
          id: class.id,
          name: class.name,
          description: class.description,
          stats: class.stats,
          skills: class.skills
        }
      end)

    %{
      data: %{
        classes: classes_with_id
      }
    }
  end

  def render("list.json", %{class: class}) do
    %{
      data: %{
        class: class
      }
    }
  end

  def render("updated.json", %{class: class}) do
    %{
      data: %{
        class: class
      },
      info: "Class updated successfully"
    }
  end

  def render("create.json", %{class: class}) do
    %{
      data: %{
        class: class
      },
      info: "Class created successfully"
    }
  end

  def render("delete.json", %{info: info}) do
    %{
      info: "Class deleted successfully"
    }
  end
end
