defmodule Alice.PageController do
  use Alice.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
