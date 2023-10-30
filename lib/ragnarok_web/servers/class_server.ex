defmodule RagnarokWeb.ClassServer do
  use GenServer
  alias Ragnarok.Repo
  alias Ragnarok.Class

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, [], opts)
  end

  def init(state) do
    {:ok, state}
  end

  def handle_call(:get_classes, _from, state) do
    classes = Repo.all(Class)
    {:reply, classes, state}
  end

  def handle_cast({:create_class, params}, state) do
    case Repo.get_by(Class, name: params["name"]) do
      nil ->
        changeset =
          Class.changeset(%Class{}, %{
              name: params["name"],
              description: params["description"],
              stats: params["stats"],
              skills: params["skills"]
          })

          case Repo.insert(changeset) do
            {:ok, _class} ->
              {:noreply, state}

            {:error, changeset} ->
              {:reply, {:error, changeset}, state}

            end
      _ ->
        {:reply, {:error, %{name: "Class with name #{params["name"]} already exists"}}, state}

    end
  end

  def get_classes do
    GenServer.call(__MODULE__, :get_classes)
  end

end
