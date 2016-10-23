defmodule Alice.FormationController do
  use Alice.Web, :controller

  alias Alice.Formation

  def index(conn, _params) do
    formations = Repo.all(Formation)
    render(conn, "index.json", formations: formations)
  end

  def create(conn, %{"formation" => formation_params}) do
    changeset = Formation.changeset(%Formation{}, formation_params)

    case Repo.insert(changeset) do
      {:ok, formation} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", formation_path(conn, :show, formation))
        |> render("show.json", formation: formation)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Alice.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    formation = Repo.get!(Formation, id)
    render(conn, "show.json", formation: formation)
  end

  def update(conn, %{"id" => id, "formation" => formation_params}) do
    formation = Repo.get!(Formation, id)
    changeset = Formation.changeset(formation, formation_params)

    case Repo.update(changeset) do
      {:ok, formation} ->
        render(conn, "show.json", formation: formation)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Alice.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    formation = Repo.get!(Formation, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(formation)

    send_resp(conn, :no_content, "")
  end
end
