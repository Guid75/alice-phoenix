defmodule Alice.Router do
  use Alice.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Alice do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", Alice do
    pipe_through :api

    resources "/formations", FormationController, except: [:new, :edit]
    resources "/students", StudentController, except: [:new, :edit]
    resources "/teachers", TeacherController, except: [:new, :edit]
  end
end
