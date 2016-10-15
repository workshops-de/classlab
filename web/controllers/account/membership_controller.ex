defmodule Classlab.Account.MembershipController do
  alias Classlab.Membership
  use Classlab.Web, :controller

  plug :scrub_params, "membership" when action in [:create, :update]

  def index(conn, _params) do
    memberships =
      Membership
      |> Repo.all()
      |> Repo.preload([:user, :role, :event])

    render(conn, "index.html", memberships: memberships)
  end

  def delete(conn, %{"id" => id}) do
    membership =
      Membership
      |> Repo.get!(id)

    Repo.delete!(membership)

    conn
    |> put_flash(:info, "Membership deleted successfully.")
    |> redirect(to: account_membership_path(conn, :index))
  end
end
