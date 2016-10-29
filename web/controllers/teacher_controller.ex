defmodule Alice.TeacherController do
  use Alice.Web, :controller

  alias Alice.Teacher

  def index(conn, _params) do
    teachers = Repo.all(Teacher)
    render(conn, "index.json", teachers: teachers)
  end

  def create(conn, %{"teacher" => teacher_params}) do
    changeset = Teacher.changeset(%Teacher{}, teacher_params)

    case Repo.insert(changeset) do
      {:ok, teacher} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", teacher_path(conn, :show, teacher))
        |> render("show.json", teacher: teacher)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Alice.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    teacher = Repo.get!(Teacher, id)
    render(conn, "show.json", teacher: teacher)
  end

  def update(conn, %{"id" => id, "teacher" => teacher_params}) do
    teacher = Repo.get!(Teacher, id)
    changeset = Teacher.changeset(teacher, teacher_params)

    case Repo.update(changeset) do
      {:ok, teacher} ->
        render(conn, "show.json", teacher: teacher)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Alice.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    teacher = Repo.get!(Teacher, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(teacher)

    send_resp(conn, :no_content, "")
  end
end
