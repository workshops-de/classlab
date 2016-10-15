defmodule Classlab.Router do
  use Classlab.Web, :router

  if Mix.env == :dev do
    forward "/sent_emails", Bamboo.EmailPreviewPlug
  end

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Classlab.AssignUserPlug
  end


  scope "/", Classlab do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/login", SessionController, :new
    post "/login", SessionController, :create
    get "/session/:id", SessionController, :show
    delete "/logout", SessionController, :delete
  end

  #############################################################################
  ### Account
  #############################################################################
  pipeline :account do
    plug :put_layout, {Classlab.LayoutView, :account}
  end

  scope "/account", Classlab.Account, as: :account do
    pipe_through [:browser, :account]

    resources "/events", EventController do
      resources "/invitations", InvitationController, except: [:edit, :update]
      resources "/materials", MaterialController
    end

    resources "/memberships", MembershipController, only: [:index, :delete]
  end

  #############################################################################
  ### Classroom
  #############################################################################
  pipeline :classroom do
    plug :put_layout, {Classlab.LayoutView, :classroom}
  end

  scope "/classroom/:event_id", Classlab.Classroom, as: :classroom do
    pipe_through [:browser, :classroom] # Use the default browser stack
    resources "/", DashboardController, only: [:show], singleton: true
    resources "/chat_messages", ChatMessageController, except: [:show]
    resources "/memberships", MembershipController, only: [:index, :delete]
  end
end
