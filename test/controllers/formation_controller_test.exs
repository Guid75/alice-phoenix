defmodule Alice.FormationControllerTest do
  use Alice.ConnCase

  alias Alice.Formation
  @valid_attrs %{title: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, formation_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    formation = Repo.insert! %Formation{}
    conn = get conn, formation_path(conn, :show, formation)
    assert json_response(conn, 200)["data"] == %{"id" => formation.id,
      "title" => formation.title}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, formation_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, formation_path(conn, :create), formation: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Formation, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, formation_path(conn, :create), formation: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    formation = Repo.insert! %Formation{}
    conn = put conn, formation_path(conn, :update, formation), formation: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Formation, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    formation = Repo.insert! %Formation{}
    conn = put conn, formation_path(conn, :update, formation), formation: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    formation = Repo.insert! %Formation{}
    conn = delete conn, formation_path(conn, :delete, formation)
    assert response(conn, 204)
    refute Repo.get(Formation, formation.id)
  end
end
