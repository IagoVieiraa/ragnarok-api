defmodule RagnarokWeb.ClassServer do
  use GenServer

  alias Ragnarok.Class
  alias Ragnarok.Repo

  # Client API

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def get_classes() do
    GenServer.call(__MODULE__, :get_classes)
  end

  def get_class_by_name(name) do
    GenServer.call(__MODULE__, {:get_class_by_name, name})
  end

  def get_class_by_id(id) do
    GenServer.call(__MODULE__, {:get_class_by_id, id})
  end

  def update_class(id, params) do
    GenServer.call(__MODULE__, {:update_class, id, params})
  end

  def create_class(params) do
    GenServer.call(__MODULE__, {:create_class, params})
  end

  def delete_class(id) do
    GenServer.call(__MODULE__, {:delete_class, id})
  end

  # Server Callbacks

  def handle_call(:get_classes, _from, state) do
    classes = Repo.all(Class)
    {:reply, classes, state}
  end

  def handle_call({:get_class_by_name, name}, _from, state) do
    class = Repo.get_by(Class, name: name)
    {:reply, class, state}
  end

  def handle_call({:get_class_by_id, id}, _from, state) do
    class = Repo.get(Class, id)
    {:reply, class, state}
  end

  def handle_call({:update_class, id, params}, _from, state) do
    class = Repo.get(Class, id)
    changeset = Class.changeset(class, params)
    {:reply, Repo.update(changeset), state}
  end

  def handle_call({:create_class, params}, _from, state) do
    changeset = Class.changeset(%Class{}, params)
    {:reply, Repo.insert(changeset), state}
  end

  def handle_call({:delete_class, id}, _from, state) do
    class = Repo.get(Class, id)
    {:reply, Repo.delete(class), state}
  end
end
