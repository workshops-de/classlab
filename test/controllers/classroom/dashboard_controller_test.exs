defmodule Classlab.Classroom.DashboardControllerTest do
  use Classlab.ConnCase

  test "#show shows chosen resource", %{conn: conn} do
    event = Factory.insert(:event)
    conn = get conn, classroom_dashboard_path(conn, :show, event)
    assert html_response(conn, 200) =~ "Dashboard"
  end
end