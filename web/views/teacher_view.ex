defmodule Alice.TeacherView do
  use Alice.Web, :view

  def render("index.json", %{teachers: teachers}) do
    %{data: render_many(teachers, Alice.TeacherView, "teacher.json")}
  end

  def render("show.json", %{teacher: teacher}) do
    %{data: render_one(teacher, Alice.TeacherView, "teacher.json")}
  end

  def render("teacher.json", %{teacher: teacher}) do
    %{id: teacher.id,
      firstName: teacher.firstName,
      lastName: teacher.lastName}
  end
end
