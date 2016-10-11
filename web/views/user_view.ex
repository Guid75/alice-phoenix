defmodule Alice.UserView do
  use Alice.Web, :view

  def render("index.json", %{users: users}) do
    %{data: render_many(users, Alice.UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, Alice.UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      firstName: user.firstName,
      lastName: user.lastName}
  end
end
