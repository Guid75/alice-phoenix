defmodule Alice.TeacherControllerTest do
  use Alice.ConnCase

  alias Alice.Teacher
  @valid_attrs %{firstName: "some content", lastName: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, teacher_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    teacher = Repo.insert! %Teacher{}
    conn = get conn, teacher_path(conn, :show, teacher)
    assert json_response(conn, 200)["data"] == %{"id" => teacher.id,
      "firstName" => teacher.firstName,
      "lastName" => teacher.lastName}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, teacher_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, teacher_path(conn, :create), teacher: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Teacher, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, teacher_path(conn, :create), teacher: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    teacher = Repo.insert! %Teacher{}
    conn = put conn, teacher_path(conn, :update, teacher), teacher: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Teacher, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    teacher = Repo.insert! %Teacher{}
    conn = put conn, teacher_path(conn, :update, teacher), teacher: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    teacher = Repo.insert! %Teacher{}
    conn = delete conn, teacher_path(conn, :delete, teacher)
    assert response(conn, 204)
    refute Repo.get(Teacher, teacher.id)
  end
end
