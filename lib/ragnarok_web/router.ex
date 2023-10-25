defmodule RagnarokWeb.Router do
  use RagnarokWeb, :router

  pipeline :browser do
    plug :fetch_session
    plug :fetch_live_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", RagnarokWeb do
    pipe_through :api

    get "/classes", PageController, :get_classes
    get "/classes/:name", PageController, :get_class_by_name
    get "/classes/id/:id", PageController, :get_class_by_id
    post "/classes", PageController, :create_class
    put "/classes/:id", PageController, :update_class
    delete "/classes/:id", PageController, :delete_class
  end

  # Other scopes may use custom stacks.
  # scope "/api", RagnarokWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:ragnarok, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: RagnarokWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
