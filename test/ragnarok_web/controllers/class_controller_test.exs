defmodule ClassControllerTest do
  use RagnarokWeb.ConnCase

  alias RagnarokWeb.ClassServer
  alias Ragnarok.Class
  alias Ragnarok.Repo

  @endpoint RagnarokWeb.ClassController

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

    # Faz uma solicitação GET para a rota :get_classes
    conn = get(build_conn(), :get_classes)

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

  test "update_class returns 200 when class is updated successfully" do
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
      "description" => "Updated description",
      "stats" => %{"attack" => 20, "defense" => 20, "hp" => 20},
      "skills" => ["skill3, skill4"]
    }

    # Faz uma solicitação PUT para a rota :update_class usando o ID da instância do modelo Class
    conn = put(build_conn(), :update_class, id: class.id, class: update_params)

    # Deserializa a resposta
    response = Poison.decode!(conn.resp_body)

    # Verifica se a resposta tem status 200 e se o nome da classe foi atualizado corretamente
    assert conn.status == 200
    assert response["data"]["class"]["name"] == "New class"
  end

  test "update_class returns 422 when class already exists" do
    # Cria duas instâncias do modelo Class
    class1 = %Class{
      name: "My Class",
      description: "This is a test class",
      stats: %{"attack" => 10, "defense" => 10, "hp" => 10},
      skills: ["skill1, skill2"]
    }

    class2 = %Class{
      name: "Another Class",
      description: "This is another test class",
      stats: %{"attack" => 20, "defense" => 20, "hp" => 20},
      skills: ["skill3, skill4"]
    }

    # Insere as instâncias do modelo Class no banco de dados
    {:ok, class1} = Repo.insert(class1)
    {:ok, class2} = Repo.insert(class2)

    # Cria um mapa com os campos a serem atualizados
    update_params = %{
      "name" => "Another Class",
      "description" => "Updated description",
      "stats" => %{"attack" => 30, "defense" => 30, "hp" => 30},
      "skills" => ["skill5, skill6"]
    }

    # Faz uma solicitação PUT para a rota :update_class usando o ID da primeira instância do modelo Class
    conn = put(build_conn(), :update_class, id: class1.id, class: update_params)

    # Verifica se a resposta tem status 422 e se a mensagem de erro é correta
    assert conn.status == 422
    assert conn.resp_body =~ "Class already exists!"
  end
end
