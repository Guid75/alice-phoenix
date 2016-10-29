defmodule Alice.StudentTest do
  use Alice.ModelCase

  alias Alice.Student

  @valid_attrs %{firstName: "some content", lastName: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Student.changeset(%Student{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Student.changeset(%Student{}, @invalid_attrs)
    refute changeset.valid?
  end
end
