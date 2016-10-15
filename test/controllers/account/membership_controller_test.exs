defmodule Classlab.Account.MembershipControllerTest do
  alias Classlab.Membership
  use Classlab.ConnCase

  @valid_attrs Factory.params_for(:membership) |> Map.take(~w[role seat_position_x seat_position_y]a)
  @invalid_attrs %{role: nil}
  @form_field "membership_role"

  test "#index lists all entries on index", %{conn: conn} do
    Factory.insert(:membership)
    conn = get conn, account_membership_path(conn, :index)
    assert html_response(conn, 200) =~ "Role"
  end

  test "#new renders form for new resources", %{conn: conn} do
    conn = get conn, account_membership_path(conn, :new)
    assert html_response(conn, 200) =~ @form_field
  end

  # test "#create creates resource and redirects when data is valid", %{conn: conn} do
  #   conn = post conn, account_membership_path(conn, :create), membership: @valid_attrs
  #   assert redirected_to(conn) == account_membership_path(conn, :index)
  #   assert Repo.get_by(Membership, @valid_attrs)
  # end

  # test "#create does not create resource and renders errors when data is invalid", %{conn: conn} do
  #   conn = post conn, account_membership_path(conn, :create), membership: @invalid_attrs
  #   assert html_response(conn, 200) =~ @form_field
  # end

  test "#delete deletes chosen resource", %{conn: conn} do
    membership = Factory.insert(:membership)
    conn = delete conn, account_membership_path(conn, :delete, membership)
    assert redirected_to(conn) == account_membership_path(conn, :index)
    refute Repo.get(Membership, membership.id)
  end
end