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
end
