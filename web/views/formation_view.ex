defmodule Alice.FormationView do
  use Alice.Web, :view

  def render("index.json", %{formations: formations}) do
    %{data: render_many(formations, Alice.FormationView, "formation.json")}
  end

  def render("show.json", %{formation: formation}) do
    %{data: render_one(formation, Alice.FormationView, "formation.json")}
  end

  def render("formation.json", %{formation: formation}) do
    %{id: formation.id,
      title: formation.title}
  end
end
