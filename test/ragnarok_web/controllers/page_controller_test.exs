defmodule PageControllerTest do
  use RagnarokWeb.ConnCase

  alias Ragnarok.Class
  alias Ragnarok.Repo

  @endpoint RagnarokWeb.PageController

  test "get_classes returns 200" do
    # Cria uma instância do modelo Class
    class = %Class{
      name: "My Class",
      description: "This is a test class",
      stats: %{"attack" => 10, "defense" => 10, "hp" => 10},
      skills: ["skill1, skill2"]
    }

    # Insere a instância do modelo Class no banco de dados
    {:ok, class} = Repo.insert(class)

    # Faz uma solicitação GET para a rota :get_classes usando o ID da instância do modelo Class
    conn = get(build_conn(), :get_classes, class_id: class.id)

    # Verifica se a resposta tem status 200
    assert conn.status == 200
  end

  test "get_classes returns 404" do
    # Faz uma solicitação GET para a rota :get_classes usando um ID inválido
    conn = get(build_conn(), :get_classes)

    # Verifica se a resposta tem status 404
    assert conn.status == 404
  end

  test "get_class_by_name returns 200" do
    # Cria uma instância do modelo Class
    class = %Class{
      name: "My Class",
      description: "This is a test class",
      stats: %{"attack" => 10, "defense" => 10, "hp" => 10},
      skills: ["skill1, skill2"]
    }

    # Insere a instância do modelo Class no banco de dados
    {:ok, _class} = Repo.insert(class)

    # Faz uma solicitação GET para a rota :get_class_by_name usando o nome da instância do modelo Class
    conn = get(build_conn(), :get_class_by_name, name: "My Class")

    # Verifica se a resposta tem status 200
    assert conn.status == 200
  end

  test "get_class_by_name returns 404" do
    # Faz uma solicitação GET para a rota :get_class_by_name usando um nome inválido
    conn = get(build_conn(), :get_class_by_name, name: "Invalid Class")

    # Verifica se a resposta tem status 404
    assert conn.status == 404
  end

  test "get_class_by_id returns 200" do
    # Cria uma instância do modelo Class
    class = %Class{
      name: "My Class",
      description: "This is a test class",
      stats: %{"attack" => 10, "defense" => 10, "hp" => 10},
      skills: ["skill1, skill2"]
    }

    # Insere a instância do modelo Class no banco de dados
    {:ok, class} = Repo.insert(class)

    # Faz uma solicitação GET para a rota :get_class_by_id usando o ID da instância do modelo Class
    conn = get(build_conn(), :get_class_by_id, id: class.id)

    # Verifica se a resposta tem status 200
    assert conn.status == 200
  end

  test "get_class_by_id returns 404" do
    # Faz uma solicitação GET para a rota :get_class_by_id usando um ID inválido
    conn = get(build_conn(), :get_class_by_id, id: 0)

    # Verifica se a resposta tem status 404
    assert conn.status == 404
  end

  test "update_class returns 200" do
    # Cria uma instância do modelo Class
    class = %Class{
      name: "My Class",
      description: "This is a test class",
      stats: %{"attack" => 10, "defense" => 10, "hp" => 10},
      skills: ["skill1, skill2"]
    }

    # Insere a instância do modelo Class no banco de dados
    {:ok, class} = Repo.insert(class)

    # Cria um mapa com os campos a serem atualizados
    update_params = %{
      "name" => "New class",
      "description" => "Lalalalala",
      "stats" => %{"attack" => 10, "defense" => 10, "hp" => 10},
      "skills" => ["skill1, skill2"]
    }

    # Cria um changeset com os campos a serem atualizados
    changeset = Class.changeset(class, update_params)

    # Atualiza o objeto Class no banco de dados com base no changeset
    {:ok, _updated_class} = Repo.update(changeset)

    # Faz uma solicitação PUT para a rota :update_class usando o ID da instância do modelo Class
    conn =
      put(build_conn(), :update_class, id: class.id)

    # Verifica se a resposta tem status 200
    assert conn.status == 200
    assert conn.resp_body =~ "New class"
  end

  test "update_class returns 404 when class is not found" do
    # Faz uma solicitação PUT para a rota :update_class com um ID inválido
    conn =
      put(build_conn(), :update_class, id: 999)

    # Verifica se a resposta tem status 404
    assert conn.status == 404
    assert conn.resp_body =~ "Class not found"
  end
end
