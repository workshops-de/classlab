defmodule Classlab.Session do
  @moduledoc """
  The session model encapsulates session handling. It can take an email address
  and an optional token.
  """
  alias Classlab.User
  use Classlab.Web, :model

  # Fields
  schema "" do
    field :email, :string
  end

  # Changesets & Validations
  @fields [:email]
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @fields)
    |> validate_required([:email])
  end

  def login(conn, %User{} = user) do
    Plug.Conn.assign(conn, :current_user, user)
  end

  def logout(conn) do
    conn
    |> Plug.Conn.delete_session(:user_id_jwt)
    |> Plug.Conn.assign(:current_user, nil)
  end
end
