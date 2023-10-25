defmodule RagnarokWeb.PageView do
  def render("list_class.json ", %{classes: classes}) do
    %{
      data: %{
        classes: classes
      }
    }
  end

  def render("update_classe.json ", %{class: class}) do
    %{
      data: %{
        class: class
      }
    }
  end

  def render("create_class.json ", %{class: class}) do
    %{
      data: %{
        class: class
      }
    }
  end

  def render("delete_classe.json ", %{class: class}) do
    %{
      data: %{
        class: class
      }
    }
  end
end
