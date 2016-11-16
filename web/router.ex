defmodule PL.Router do
  use PL.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug PL.Plug.Locale
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PL do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/set-locale", PageController, :set_locale
    get "/download-resume", PageController, :download_resume


    resources "/message", MessageController, singleton: true,
      only: [:new, :create]
    get "/success", MessageController, :success
  end

  # Other scopes may use custom stacks.
  # scope "/api", PL do
  #   pipe_through :api
  # end
end
