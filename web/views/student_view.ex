defmodule Alice.StudentView do
  use Alice.Web, :view

  def render("index.json", %{students: students}) do
    %{data: render_many(students, Alice.StudentView, "student.json")}
  end

  def render("show.json", %{student: student}) do
    %{data: render_one(student, Alice.StudentView, "student.json")}
  end

  def render("student.json", %{student: student}) do
    %{id: student.id,
      firstName: student.firstName,
      lastName: student.lastName}
  end
end
