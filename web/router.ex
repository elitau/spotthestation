defmodule SpotTheStation.Router do
  use SpotTheStation.Web, :router

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

  scope "/", SpotTheStation do
    pipe_through :browser # Use the default browser stack

    get "/",            PageController, :index
    get "/cologne.ics", PageController, :cologne
    get "/for_city",    PageController, :for_city
  end

  # Other scopes may use custom stacks.
  # scope "/api", SpotTheStation do
  #   pipe_through :api
  # end
end
